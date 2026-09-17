<?php

namespace App\Http\Controllers;

use App\Models\Sppd;
use App\Models\SppdRincian;
use App\Models\RefProvinsi;
use App\Models\RefTarifHarian;
use App\Models\RefTarifPenginapan;
use App\Models\RefTarifPesawat;
use App\Models\RefTarifTransportDarat;
use App\Models\RefTarifTransportProvinsi;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

use App\Models\Pegawai;

class SppdController extends Controller
{
    public function index(): Response
    {
        $sppdList = Sppd::with('provinsi')
            ->orderBy('created_at', 'desc')
            ->get();

        return Inertia::render('Sppd/Index', [
            'sppdList' => $sppdList,
        ]);
    }

    public function create(): Response
    {
        $provinsi = RefProvinsi::orderBy('id_provinsi')->get();
        $pegawais = Pegawai::orderBy('nama_pegawai')->get();

        return Inertia::render('Sppd/Create', [
            'provinsi' => $provinsi,
            'pegawais' => $pegawais,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'atas_nama' => 'required|string|max:150',
            'nip' => 'nullable|string|max:30',
            'pangkat_golongan' => 'nullable|string|max:50',
            'jabatan' => 'nullable|string|max:100',
            'tanggal_mulai' => 'required|date',
            'tanggal_selesai' => 'required|date|after_or_equal:tanggal_mulai',
            'tujuan_daerah' => 'required|string|max:100',
            'provinsi_tujuan' => 'required|integer|exists:ref_provinsi,id_provinsi',
            'keperluan' => 'nullable|string',
        ]);

        $lamaHari = (int) \Carbon\Carbon::parse($validated['tanggal_mulai'])->diffInDays($validated['tanggal_selesai']) + 1;
        $validated['lama_hari'] = $lamaHari;
        $validated['asal_daerah'] = 'Sigli';
        $validated['status'] = 'draft';
        $validated['total_biaya'] = 0;
        $validated['created_by'] = $request->user()->id;

        $validated['nomor_sppd'] = $this->generateNomor();

        $sppd = Sppd::create($validated);

        return response()->json([
            'message' => 'SPPD berhasil dibuat.',
            'sppd' => $sppd->load('provinsi'),
        ], 201);
    }

    public function show(Sppd $sppd): Response
    {
        $sppd->load(['rincian', 'provinsi']);

        $provinsi = RefProvinsi::orderBy('id_provinsi')->get();

        return Inertia::render('Sppd/Show', [
            'sppd' => $sppd,
            'provinsi' => $provinsi,
        ]);
    }

    public function edit(Sppd $sppd): Response
    {
        $sppd->load('provinsi');

        $provinsi = RefProvinsi::orderBy('id_provinsi')->get();
        $pegawais = Pegawai::orderBy('nama_pegawai')->get();

        return Inertia::render('Sppd/Edit', [
            'sppd' => $sppd,
            'provinsi' => $provinsi,
            'pegawais' => $pegawais,
        ]);
    }

    public function update(Request $request, Sppd $sppd)
    {
        $validated = $request->validate([
            'atas_nama' => 'sometimes|string|max:150',
            'nip' => 'nullable|string|max:30',
            'pangkat_golongan' => 'nullable|string|max:50',
            'jabatan' => 'nullable|string|max:100',
            'tanggal_mulai' => 'sometimes|date',
            'tanggal_selesai' => 'sometimes|date|after_or_equal:tanggal_mulai',
            'tujuan_daerah' => 'sometimes|string|max:100',
            'provinsi_tujuan' => 'sometimes|integer|exists:ref_provinsi,id_provinsi',
            'keperluan' => 'nullable|string',
            'status' => 'sometimes|in:draft,proses,selesai,batal',
        ]);

        if (isset($validated['tanggal_mulai'], $validated['tanggal_selesai'])) {
            $validated['lama_hari'] = (int) \Carbon\Carbon::parse($validated['tanggal_mulai'])->diffInDays($validated['tanggal_selesai']) + 1;
        }

        if (isset($validated['status'])) {
            if ($validated['status'] === 'selesai') $validated['approved_by'] = $request->user()->id;
            if ($validated['status'] === 'selesai') $validated['paid_by'] = $request->user()->id;
        }

        $sppd->update($validated);

        return response()->json([
            'message' => 'SPPD berhasil diperbarui.',
            'sppd' => $sppd->load('provinsi'),
        ]);
    }

    public function destroy(Sppd $sppd)
    {
        $sppd->delete();
        return response()->json(['message' => 'SPPD berhasil dihapus.']);
    }

    public function calculate(Request $request)
    {
        $validated = $request->validate([
            'provinsi_tujuan' => 'required|integer|exists:ref_provinsi,id_provinsi',
            'tanggal_mulai' => 'required|date',
            'tanggal_selesai' => 'required|date|after_or_equal:tanggal_mulai',
            'golongan' => 'required|in:eselon_1,eselon_2,eselon_3,eselon_4',
            'transport_udara' => 'nullable|boolean',
            'transport_darat_pp' => 'nullable|boolean',
            'taksi_bandara' => 'nullable|boolean',
            'kota_asal_pesawat' => 'nullable|string',
            'kota_tujuan_pesawat' => 'nullable|string',
        ]);

        $provinsi = RefProvinsi::find($validated['provinsi_tujuan']);
        $lamaHari = (int) \Carbon\Carbon::parse($validated['tanggal_mulai'])->diffInDays($validated['tanggal_selesai']) + 1;

        $tarifHarian = RefTarifHarian::where('id_provinsi', $validated['provinsi_tujuan'])->first();
        $tarifPenginapan = RefTarifPenginapan::where('id_provinsi', $validated['provinsi_tujuan'])->first();
        $golonganMap = [
            'eselon_1' => 'pejabat_negara_eselon_1',
            'eselon_2' => 'pejabat_lainnya_eselon_2',
            'eselon_3' => 'eselon_3_gol_4',
            'eselon_4' => 'eselon_4_gol_3_2_1',
        ];

        $rincian = [];
        $total = 0;

        if ($tarifHarian) {
            $satuan = $tarifHarian->luar_kota;
            $jumlah = $satuan * $lamaHari;
            $rincian[] = ['jenis_biaya' => 'uang_harian', 'uraian' => 'Uang Harian', 'hari' => $lamaHari, 'satuan' => $satuan, 'jumlah' => $jumlah, 'keterangan' => "Tingkat Satuan ($lamaHari hari)"];
            $total += $jumlah;
        }

        if ($tarifPenginapan) {
            $golKey = $golonganMap[$validated['golongan']] ?? 'eselon_4_gol_3_2_1';
            $satuan = $tarifPenginapan->$golKey;
            $hariInap = max(1, $lamaHari - 1);
            $jumlah = $satuan * $hariInap;
            $rincian[] = ['jenis_biaya' => 'penginapan', 'uraian' => 'Penginapan', 'hari' => $hariInap, 'satuan' => $satuan, 'jumlah' => $jumlah, 'keterangan' => 'Terlampir'];
            $total += $jumlah;
        }

        if (!empty($validated['transport_udara']) && !empty($validated['kota_asal_pesawat']) && !empty($validated['kota_tujuan_pesawat'])) {
            $asal = strtoupper(trim($validated['kota_asal_pesawat']));
            $tujuan = strtoupper(trim($validated['kota_tujuan_pesawat']));
            $pesawat = RefTarifPesawat::whereRaw('UPPER(kota_asal) = ?', [$asal])
                ->whereRaw('UPPER(kota_tujuan) = ?', [$tujuan])->first();

            if ($pesawat) {
                $rincian[] = ['jenis_biaya' => 'transport_udara_pergi', 'uraian' => "Transportasi Udara (Pergi) $asal - $tujuan", 'hari' => 1, 'satuan' => $pesawat->tarif_ekonomi, 'jumlah' => $pesawat->tarif_ekonomi, 'keterangan' => 'Terlampir'];
                $rincian[] = ['jenis_biaya' => 'transport_udara_pulang', 'uraian' => "Transportasi Udara (Pulang) $tujuan - $asal", 'hari' => 1, 'satuan' => $pesawat->tarif_ekonomi, 'jumlah' => $pesawat->tarif_ekonomi, 'keterangan' => 'Terlampir'];
                $total += $pesawat->tarif_ekonomi * 2;
            }
        }

        if (!empty($validated['transport_darat_pp'])) {
            $ibukotaProv = $provinsi->ibukota ?? '';
            $tujuanDar = RefTarifTransportDarat::whereRaw('UPPER(ibukota_provinsi) = ?', [strtoupper($ibukotaProv)])
                ->whereRaw('UPPER(kabupaten_kota_tujuan) = ?', ['SIGLI'])->first();

            if (!$tujuanDar) {
                $tujuanDar = RefTarifTransportDarat::where('ibukota_provinsi', 'like', '%' . $ibukotaProv . '%')
                    ->where('kabupaten_kota_tujuan', 'like', '%Sigli%')->first();
            }

            if ($tujuanDar) {
                $pp = $tujuanDar->besaran * 2;
                $rincian[] = ['jenis_biaya' => 'transport_darat', 'uraian' => "Kendaraan Dinas (PP) Dari Sigli - $ibukotaProv", 'hari' => 1, 'satuan' => $tujuanDar->besaran * 2, 'jumlah' => $pp, 'keterangan' => 'PP'];
                $total += $pp;
            }
        }

        if (!empty($validated['taksi_bandara'])) {
            $taksi = 500000;
            $rincian[] = ['jenis_biaya' => 'taksi_bandara', 'uraian' => 'Taksi Bandara Hotel-PP', 'hari' => 1, 'satuan' => $taksi, 'jumlah' => $taksi, 'keterangan' => 'Terlampir'];
            $total += $taksi;
        }

        return response()->json([
            'rincian' => $rincian,
            'total_biaya' => $total,
            'lama_hari' => $lamaHari,
            'terbilang' => $this->terbilang($total),
        ]);
    }

    public function storeRincian(Request $request, Sppd $sppd)
    {
        $validated = $request->validate([
            'rincian' => 'required|array',
            'rincian.*.jenis_biaya' => 'required|string',
            'rincian.*.uraian' => 'required|string',
            'rincian.*.hari' => 'required|integer|min:1',
            'rincian.*.satuan' => 'required|integer|min:0',
            'rincian.*.jumlah' => 'required|integer|min:0',
            'rincian.*.keterangan' => 'nullable|string',
        ]);

        $sppd->rincian()->delete();

        foreach ($validated['rincian'] as $item) {
            $sppd->rincian()->create($item);
        }

        $totalBiaya = $sppd->rincian()->sum('jumlah');
        $sppd->update(['total_biaya' => $totalBiaya]);

        return response()->json([
            'message' => 'Rincian biaya berhasil disimpan.',
            'sppd' => $sppd->fresh('rincian'),
        ]);
    }

    public function cetak(Sppd $sppd): Response
    {
        $sppd->load(['rincian', 'provinsi', 'creator', 'approver', 'payer']);

        return Inertia::render('Sppd/Cetak', [
            'sppd' => $sppd,
        ]);
    }

    private function generateNomor(): string
    {
        $year = date('y');
        $month = date('m');
        $last = Sppd::where('nomor_sppd', 'like', "SPD-$year$month%")->count();
        $seq = str_pad($last + 1, 4, '0', STR_PAD_LEFT);
        return "SPD-$year$month$seq";
    }

    private function terbilang($angka): string
    {
        $huruf = ['', 'satu', 'dua', 'tiga', 'empat', 'lima', 'enam', 'tujuh', 'delapan', 'sembilan', 'sepuluh', 'sebelas'];
        if ($angka < 12) return $huruf[$angka];
        if ($angka < 20) return $huruf[$angka - 10] . ' belas';
        if ($angka < 100) {
            $x = intdiv($angka, 10);
            $sisa = $angka % 10;
            return ($x == 1 ? 'se' : $huruf[$x] . ' ') . 'puluh' . ($sisa > 0 ? ' ' . $huruf[$sisa] : '');
        }
        if ($angka < 200) return 'seratus ' . $this->terbilang($angka - 100);
        if ($angka < 1000) {
            $x = intdiv($angka, 100);
            $sisa = $angka % 100;
            return $huruf[$x] . ' ratus' . ($sisa > 0 ? ' ' . $this->terbilang($sisa) : '');
        }
        if ($angka < 2000) return 'seribu ' . $this->terbilang($angka - 1000);
        if ($angka < 1000000) {
            $x = intdiv($angka, 1000);
            $sisa = $angka % 1000;
            return $this->terbilang($x) . ' ribu' . ($sisa > 0 ? ' ' . $this->terbilang($sisa) : '');
        }
        if ($angka < 1000000000) {
            $x = intdiv($angka, 1000000);
            $sisa = $angka % 1000000;
            return $this->terbilang($x) . ' juta' . ($sisa > 0 ? ' ' . $this->terbilang($sisa) : '');
        }
        return (string) $angka;
    }
}