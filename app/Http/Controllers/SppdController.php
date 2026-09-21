<?php

namespace App\Http\Controllers;

use App\Models\Pegawai;
use App\Models\RefProvinsi;
use App\Models\RefTarifHarian;
use App\Models\RefTarifPenginapan;
use App\Models\RefTarifPesawat;
use App\Models\RefTarifTransportDarat;
use App\Models\RefTarifTransportProvinsi;
use App\Models\Sppd;
use App\Services\LaporanSppdService;
use Carbon\Carbon;
use Dompdf\Dompdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx as XlsxWriter;

class SppdController extends Controller
{
    public function index(): Response
    {
        $sppdList = Sppd::with(['provinsi', 'pegawai'])
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
            'jenis_sppd' => 'nullable|in:dalam,luar',
            'nomor_sppd' => 'nullable|string|max:50|unique:tb_sppd,nomor_sppd',
            'transport_udara' => 'nullable|boolean',
            'transport_darat_pp' => 'nullable|boolean',
            'taksi_bandara' => 'nullable|boolean',
            'transport_kendaraan_dinas_pp' => 'nullable|boolean',
            'golongan' => 'nullable|in:eselon_1,eselon_2,eselon_3,eselon_4',
            'kota_asal_pesawat' => 'nullable|string|max:100',
            'kota_tujuan_pesawat' => 'nullable|string|max:100',
        ]);

        $lamaHari = (int) Carbon::parse($validated['tanggal_mulai'])->diffInDays($validated['tanggal_selesai']) + 1;
        $validated['lama_hari'] = $lamaHari;
        $validated['tahun'] = (int) Carbon::parse($validated['tanggal_mulai'])->year;
        $validated['asal_daerah'] = 'Sigli';
        $validated['jenis_sppd'] = $validated['jenis_sppd'] ?? 'luar';
        $validated['status'] = 'draft';
        $validated['total_biaya'] = 0;
        $validated['created_by'] = $request->user()->id;

        $validated['nomor_sppd'] = ! empty($validated['nomor_sppd']) ? $validated['nomor_sppd'] : $this->generateNomor();

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
        $sppd->load(['provinsi', 'rincian']);

        $provinsi = RefProvinsi::orderBy('id_provinsi')->get();
        $pegawais = Pegawai::orderBy('nama_pegawai')->get();

        return Inertia::render('Sppd/Create', [
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
            'jenis_sppd' => 'nullable|in:dalam,luar',
            'status' => 'sometimes|in:draft,proses,selesai,batal',
            'nomor_sppd' => 'sometimes|nullable|string|max:50|unique:tb_sppd,nomor_sppd,'.$sppd->id,
            'transport_udara' => 'nullable|boolean',
            'transport_darat_pp' => 'nullable|boolean',
            'taksi_bandara' => 'nullable|boolean',
            'transport_kendaraan_dinas_pp' => 'nullable|boolean',
            'golongan' => 'nullable|in:eselon_1,eselon_2,eselon_3,eselon_4',
            'kota_asal_pesawat' => 'nullable|string|max:100',
            'kota_tujuan_pesawat' => 'nullable|string|max:100',
        ]);

        if (isset($validated['tanggal_mulai'], $validated['tanggal_selesai'])) {
            $validated['lama_hari'] = (int) Carbon::parse($validated['tanggal_mulai'])->diffInDays($validated['tanggal_selesai']) + 1;
            $validated['tahun'] = (int) Carbon::parse($validated['tanggal_mulai'])->year;
        }

        if (isset($validated['status'])) {
            if ($validated['status'] === 'selesai') {
                $validated['approved_by'] = $request->user()->id;
            }
            if ($validated['status'] === 'selesai') {
                $validated['paid_by'] = $request->user()->id;
            }
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
            'jenis_sppd' => 'nullable|in:dalam,luar',
            'transport_udara' => 'nullable|boolean',
            'transport_darat_pp' => 'nullable|boolean',
            'taksi_bandara' => 'nullable|boolean',
            'transport_kendaraan_dinas_pp' => 'nullable|boolean',
            'kota_asal_pesawat' => 'nullable|string',
            'kota_tujuan_pesawat' => 'nullable|string',
            'uang_saku' => 'nullable|numeric|min:0',
            'uang_saku_hari' => 'nullable|integer|min:0',
        ]);

        $provinsi = RefProvinsi::find($validated['provinsi_tujuan']);
        $lamaHari = (int) Carbon::parse($validated['tanggal_mulai'])->diffInDays($validated['tanggal_selesai']) + 1;

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

        if (! empty($validated['transport_udara']) && ! empty($validated['kota_asal_pesawat']) && ! empty($validated['kota_tujuan_pesawat'])) {
            $asal = strtoupper(trim($validated['kota_asal_pesawat']));
            $tujuan = strtoupper(trim($validated['kota_tujuan_pesawat']));
            $pesawat = RefTarifPesawat::whereRaw('UPPER(kota_asal) = ?', [$asal])
                ->whereRaw('UPPER(kota_tujuan) = ?', [$tujuan])->first();

            if (! $pesawat) {
                $pesawat = RefTarifPesawat::whereRaw('UPPER(kota_asal) = ?', [$tujuan])
                    ->whereRaw('UPPER(kota_tujuan) = ?', [$asal])->first();
            }

            $tarifPesawat = $pesawat ? $pesawat->tarif_ekonomi : 0;
            $keteranganPesawat = $pesawat ? 'Terlampir' : 'Tarif tidak ditemukan';

            $rincian[] = ['jenis_biaya' => 'transport_udara_pergi', 'uraian' => "Transportasi Udara (Pergi) $asal - $tujuan", 'hari' => 1, 'satuan' => $tarifPesawat, 'jumlah' => $tarifPesawat, 'keterangan' => $keteranganPesawat];
            $rincian[] = ['jenis_biaya' => 'transport_udara_pulang', 'uraian' => "Transportasi Udara (Pulang) $tujuan - $asal", 'hari' => 1, 'satuan' => $tarifPesawat, 'jumlah' => $tarifPesawat, 'keterangan' => $keteranganPesawat];
            $total += $tarifPesawat * 2;
        }

        if (! empty($validated['transport_darat_pp'])) {
            $tujuanDar = RefTarifTransportDarat::whereRaw('UPPER(ibukota_provinsi) = ?', ['BANDA ACEH'])
                ->whereRaw('UPPER(kabupaten_kota_tujuan) = ?', ['KAB. PIDIE'])->first();

            $ppDarat = $tujuanDar ? $tujuanDar->besaran * 2 : 0;
            $rincian[] = ['jenis_biaya' => 'transport_darat', 'uraian' => 'Dari Sigli - Banda Aceh', 'hari' => 1, 'satuan' => $ppDarat, 'jumlah' => $ppDarat, 'keterangan' => $tujuanDar ? 'PP' : 'Tarif tidak ditemukan'];
            $total += $ppDarat;

            $tarifProvinsi = RefTarifTransportProvinsi::where('id_provinsi', 1)->first();
            $ppBandara = $tarifProvinsi ? $tarifProvinsi->besaran * 2 : 0;
            $rincian[] = ['jenis_biaya' => 'transport_darat', 'uraian' => 'Dari Banda Aceh - Bandara SIM', 'hari' => 1, 'satuan' => $ppBandara, 'jumlah' => $ppBandara, 'keterangan' => $tarifProvinsi ? 'PP' : 'Tarif tidak ditemukan'];
            $total += $ppBandara;
        }

        if (! empty($validated['transport_kendaraan_dinas_pp'])) {
            $rincian[] = ['jenis_biaya' => 'transport_dinas_pp', 'uraian' => 'Kendaraan Dinas (PP)', 'hari' => 1, 'satuan' => 0, 'jumlah' => 0, 'keterangan' => 'Manual'];
        }

        if (! empty($validated['taksi_bandara'])) {
            $taksi = 500000;
            $rincian[] = ['jenis_biaya' => 'taksi_bandara', 'uraian' => 'Taksi Bandara Hotel-PP', 'hari' => 1, 'satuan' => $taksi, 'jumlah' => $taksi, 'keterangan' => 'Terlampir'];
            $total += $taksi;
        }

        $uangSaku = (int) ($validated['uang_saku'] ?? 0);
        $uangSakuHari = (int) ($validated['uang_saku_hari'] ?? 0);
        if ($uangSaku > 0 || $uangSakuHari > 0) {
            $hariUangSaku = $uangSakuHari > 0 ? $uangSakuHari : $lamaHari;
            $jumlahUangSaku = $uangSaku * $hariUangSaku;
            $rincian[] = ['jenis_biaya' => 'uang_saku', 'uraian' => 'Uang Saku', 'hari' => $hariUangSaku, 'satuan' => $uangSaku, 'jumlah' => $jumlahUangSaku, 'keterangan' => 'Manual'];
            $total += $jumlahUangSaku;
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
            'rincian.*.bukti' => 'nullable|string|max:255',
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

    public function uploadBukti(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:pdf,jpg,jpeg,png,webp|max:5120',
        ]);

        $path = $request->file('file')->store('sppd/bukti', 'public');

        return response()->json([
            'message' => 'Bukti berhasil diunggah.',
            'path' => $path,
            'url' => '/storage/'.ltrim($path, '/'),
        ]);
    }

    public function uploadDokumen(Request $request, Sppd $sppd)
    {
        $validated = $request->validate([
            'jenis' => 'required|in:surat_tugas,sppd,laporan',
            'file' => 'required|file|mimes:pdf,jpg,jpeg,png,webp|max:10240',
        ]);

        $column = $this->dokumenColumn($validated['jenis']);

        if ($sppd->{$column}) {
            Storage::disk('public')->delete($sppd->{$column});
        }

        $path = $request->file('file')->store('sppd/dokumen', 'public');
        $sppd->update([$column => $path]);

        return response()->json([
            'message' => 'Dokumen berhasil diunggah.',
            'jenis' => $validated['jenis'],
            'path' => $path,
            'url' => '/storage/'.ltrim($path, '/'),
        ]);
    }

    public function hapusDokumen(Request $request, Sppd $sppd)
    {
        $validated = $request->validate([
            'jenis' => 'required|in:surat_tugas,sppd,laporan',
        ]);

        $column = $this->dokumenColumn($validated['jenis']);

        if ($sppd->{$column}) {
            Storage::disk('public')->delete($sppd->{$column});
        }

        $sppd->update([$column => null]);

        return response()->json([
            'message' => 'Dokumen berhasil dihapus.',
            'jenis' => $validated['jenis'],
        ]);
    }

    private function dokumenColumn(string $jenis): string
    {
        return match ($jenis) {
            'surat_tugas' => 'file_surat_tugas',
            'laporan' => 'file_laporan',
            default => 'file_sppd',
        };
    }

    public function cetak(Sppd $sppd): Response
    {
        $sppd->load(['rincian', 'provinsi', 'creator', 'approver', 'payer']);

        return Inertia::render('Sppd/Cetak', [
            'sppd' => $sppd,
        ]);
    }

    public function cetakPerincian(Sppd $sppd): Response
    {
        $sppd->load(['rincian', 'provinsi', 'pegawai', 'creator', 'approver', 'payer']);

        return Inertia::render('Sppd/CetakPerincian', [
            'sppd' => $sppd,
            'terbilang' => $this->terbilang((int) $sppd->total_biaya),
        ]);
    }

    public function laporan(): Response
    {
        return Inertia::render('Sppd/Laporan', [
            'sppdList' => Sppd::orderBy('nomor_sppd')->get(['id', 'nomor_sppd', 'atas_nama']),
            'jenisLaporan' => LaporanSppdService::JENIS,
        ]);
    }

    public function laporanPreview(Request $request)
    {
        [$jenis, $awal, $akhir, $nomor] = $this->validateLaporan($request);

        ['view' => $view, 'orientasi' => $orientasi] = $this->laporanOrientasi($jenis);

        return response(view($view, $this->laporanViewData($jenis, $awal, $akhir, $nomor)));
    }

    public function laporanExportPdf(Request $request)
    {
        [$jenis, $awal, $akhir, $nomor] = $this->validateLaporan($request);

        ['view' => $view, 'orientasi' => $orientasi] = $this->laporanOrientasi($jenis);

        $dompdf = new Dompdf(['isRemoteEnabled' => false]);
        $dompdf->loadHtml(view($view, $this->laporanViewData($jenis, $awal, $akhir, $nomor))->render());
        $dompdf->setPaper('A4', $orientasi);
        $dompdf->render();

        $service = app(LaporanSppdService::class);
        $namaFile = $service->namaFile($jenis, $awal, $akhir, $nomor).'.pdf';

        return response($dompdf->output(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="'.$namaFile.'"',
        ]);
    }

    public function laporanExportExcel(Request $request)
    {
        [$jenis, $awal, $akhir, $nomor] = $this->validateLaporan($request);

        $service = app(LaporanSppdService::class);
        $data = $service->data($jenis, $awal, $akhir, $nomor);

        $spreadsheet = $this->buildExcelWorkbook($service, $jenis, $data, $awal, $akhir, $nomor);

        $namaFile = $service->namaFile($jenis, $awal, $akhir, $nomor).'.xlsx';

        $writer = new XlsxWriter($spreadsheet);
        ob_start();
        $writer->save('php://output');
        $content = ob_get_clean();

        return response($content, 200, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            'Content-Disposition' => 'attachment; filename="'.$namaFile.'"',
        ]);
    }

    private function validateLaporan(Request $request): array
    {
        $validated = $request->validate([
            'jenis' => 'required|string|in:rekap,rincian,pegawai,tujuan,status',
            'tgl_awal' => 'nullable|date',
            'tgl_akhir' => 'nullable|date|after_or_equal:tgl_awal',
            'nomor_sppd' => 'nullable|string|max:50',
        ]);

        if ($validated['jenis'] === 'rincian' && empty($validated['nomor_sppd'])) {
            abort(422, 'Nomor SPPD wajib diisi untuk laporan rincian biaya.');
        }

        return [
            $validated['jenis'],
            $validated['tgl_awal'] ?? null,
            $validated['tgl_akhir'] ?? null,
            $validated['nomor_sppd'] ?? null,
        ];
    }

    private function laporanOrientasi(string $jenis): array
    {
        return $jenis === 'rekap'
            ? ['view' => "laporan.$jenis", 'orientasi' => 'landscape']
            : ['view' => "laporan.$jenis", 'orientasi' => 'portrait'];
    }

    private function laporanViewData(string $jenis, ?string $awal, ?string $akhir, ?string $nomor): array
    {
        $service = app(LaporanSppdService::class);
        $data = $service->data($jenis, $awal, $akhir, $nomor);

        $periode = 'Semua';
        if ($awal && $akhir) {
            $periode = $this->tanggalIndo($awal).' s/d '.$this->tanggalIndo($akhir);
        } elseif ($awal) {
            $periode = 'Mulai '.$this->tanggalIndo($awal);
        } elseif ($akhir) {
            $periode = 'Sampai '.$this->tanggalIndo($akhir);
        }

        $filter = ['Jenis Laporan' => $service->namaLaporan($jenis), 'Periode' => $periode];

        if ($jenis === 'rincian') {
            $filter['Nomor SPPD'] = $nomor;
        }

        return [
            'judul' => 'Laporan '.$service->namaLaporan($jenis),
            'orientasi' => $jenis === 'rekap' ? 'A4 landscape' : 'A4 portrait',
            'filter' => $filter,
            'data' => $data,
            'tanggal' => $this->tanggalIndo(now()),
        ];
    }

    private function buildExcelWorkbook(
        LaporanSppdService $service,
        string $jenis,
        array $data,
        ?string $awal,
        ?string $akhir,
        ?string $nomor
    ): Spreadsheet {
        $spreadsheet = new Spreadsheet;
        $sheet = $spreadsheet->getActiveSheet();

        $judul = 'Laporan '.$service->namaLaporan($jenis);
        $sheet->setCellValue('A1', $judul);
        $sheet->getStyle('A1')->getFont()->setBold(true)->setSize(14);

        $periode = ($awal ?: 'awal').' s/d '.($akhir ?: 'akhir');
        $sheet->setCellValue('A2', 'Periode: '.$periode);
        if ($jenis === 'rincian') {
            $sheet->setCellValue('A3', 'Nomor SPPD: '.($nomor ?: '-'));
        }

        $lastCol = 6;

        if ($jenis === 'rincian') {
            $row = $this->writeExcelRincian($sheet, $data);
        } else {
            $headers = $this->excelHeaders($jenis);
            $lastCol = count($headers);
            $sheet->mergeCells([1, 1, $lastCol, 1]);
            $sheet->mergeCells([1, 2, $lastCol, 2]);

            $headerRow = 4;
            $col = 1;
            foreach ($headers as $h) {
                $sheet->setCellValue([$col++, $headerRow], $h);
            }

            $style = $sheet->getStyle([1, $headerRow, $col - 1, $headerRow]);
            $style->getFont()->setBold(true);
            $style->getFill()->setFillType(Fill::FILL_SOLID)->getStartColor()->setARGB('FFDDEBF7');
            $style->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);

            $row = $headerRow + 1;
            foreach ($data['rows'] as $i => $r) {
                $this->writeExcelRow($sheet, $jenis, $i + 1, $r, $row);
                $row++;
            }

            if ($data['rows']->count() > 0) {
                $this->writeExcelTotals($sheet, $jenis, $data, $row, $lastCol);
            }
        }

        foreach (range(1, $lastCol) as $c) {
            $sheet->getColumnDimension($sheet->getCell([$c, $row])->getColumn())->setAutoSize(true);
        }

        return $spreadsheet;
    }

    private function writeExcelRincian($sheet, array $data): int
    {
        $sppd = $data['sppd'];
        if (! $sppd) {
            $sheet->setCellValue('A4', 'SPPD tidak ditemukan.');

            return 4;
        }

        $row = 5;
        $sheet->setCellValue([1, $row], 'Atas Nama');
        $sheet->setCellValue([3, $row], $sppd->atas_nama);
        $row++;
        $sheet->setCellValue([1, $row], 'NIP');
        $sheet->setCellValue([3, $row], $sppd->nip ?: '-');
        $row++;
        $sheet->setCellValue([1, $row], 'Jabatan');
        $sheet->setCellValue([3, $row], $sppd->jabatan ?: '-');
        $row++;
        $sheet->setCellValue([1, $row], 'Tujuan');
        $sheet->setCellValue([3, $row], $sppd->tujuan_daerah.' ('.($sppd->provinsi?->nama_provinsi ?: '-').')');
        $row++;
        $sheet->setCellValue([1, $row], 'Tanggal');
        $sheet->setCellValue([3, $row], $sppd->tanggal_mulai->format('d-m-Y').' s/d '.$sppd->tanggal_selesai->format('d-m-Y').' ('.$sppd->lama_hari.' hari)');
        $row += 2;

        $sheet->setCellValue([1, $row], 'Rincian Biaya');
        $sheet->getStyle([1, $row, 6, $row])->getFont()->setBold(true);
        $row++;

        $rincianHeaders = ['No', 'Perincian Biaya', 'Hari', 'Satuan', 'Jumlah', 'Keterangan'];
        foreach (array_values($rincianHeaders) as $idx => $h) {
            $sheet->setCellValue([$idx + 1, $row], $h);
        }
        $headerStyle = $sheet->getStyle([1, $row, 6, $row]);
        $headerStyle->getFont()->setBold(true);
        $headerStyle->getFill()->setFillType(Fill::FILL_SOLID)->getStartColor()->setARGB('FFDDEBF7');
        $headerStyle->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);
        $row++;

        foreach ($sppd->rincian as $i => $rc) {
            $sheet->setCellValue([1, $row], $i + 1);
            $sheet->setCellValue([2, $row], $rc->uraian);
            $sheet->setCellValue([3, $row], $rc->hari);
            $sheet->setCellValue([4, $row], $rc->satuan);
            $sheet->setCellValue([5, $row], $rc->jumlah);
            $sheet->setCellValue([6, $row], $rc->keterangan);
            $sheet->getStyle([1, $row, 6, $row])->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);
            $sheet->getStyle([3, $row])->getNumberFormat()->setFormatCode('#,##0');
            $sheet->getStyle([4, $row])->getNumberFormat()->setFormatCode('#,##0');
            $sheet->getStyle([5, $row])->getNumberFormat()->setFormatCode('#,##0');
            $row++;
        }

        $sheet->setCellValue([1, $row], 'Jumlah Biaya');
        $sheet->mergeCells([1, $row, 4, $row]);
        $sheet->setCellValue([5, $row], $sppd->total_biaya);
        $sheet->getStyle([1, $row, 5, $row])->getFont()->setBold(true);
        $sheet->getStyle([1, $row, 5, $row])->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);
        $sheet->getStyle([5, $row])->getNumberFormat()->setFormatCode('#,##0');
        $row++;

        if ($data['terbilang']) {
            $sheet->setCellValue([1, $row], 'Terbilang: '.$data['terbilang'].' rupiah');
            $sheet->getStyle([1, $row])->getFont()->setItalic(true);
        }

        return $row;
    }

    private function excelHeaders(string $jenis): array
    {
        return match ($jenis) {
            'rekap' => ['No', 'Nomor SPPD', 'Atas Nama', 'NIP / Jabatan', 'Tujuan', 'Tanggal', 'Lama Hari', 'Status', 'Total Biaya'],
            'pegawai' => ['No', 'Nama Pegawai', 'NIP', 'Pangkat / Golongan', 'Jabatan', 'Jumlah SPPD', 'Jumlah Hari', 'Total Biaya'],
            'tujuan' => ['No', 'Daerah Tujuan', 'Provinsi', 'Jumlah SPPD', 'Jumlah Hari', 'Total Biaya'],
            'status' => ['No', 'Status', 'Jumlah SPPD', 'Jumlah Hari', 'Total Biaya'],
            default => ['No', 'Atas Nama', 'NIP', 'Jabatan', 'Tujuan', 'Tanggal', 'Total Biaya'],
        };
    }

    private function writeExcelRow($sheet, string $jenis, int $no, array $r, int $row): void
    {
        $c = 1;
        $sheet->setCellValue([$c++, $row], $no);
        $sheet->setCellValue([$c++, $row], $r['nomor_sppd'] ?? $r['atas_nama'] ?? $r['tujuan_daerah'] ?? $r['status'] ?? '');
        if ($jenis === 'rekap') {
            $sheet->setCellValue([$c++, $row], $r['atas_nama']);
            $sheet->setCellValue([$c++, $row], ($r['nip'] ?: '-').' - '.($r['jabatan'] ?: '-'));
            $sheet->setCellValue([$c++, $row], $r['tujuan_daerah'].' ('.$r['provinsi'].')');
            $sheet->setCellValue([$c++, $row], $r['tanggal_mulai'].' s/d '.$r['tanggal_selesai']);
            $sheet->setCellValue([$c++, $row], $r['lama_hari']);
            $sheet->setCellValue([$c++, $row], $r['status']);
            $sheet->setCellValue([$c++, $row], $r['total_biaya']);
        } elseif ($jenis === 'pegawai') {
            $sheet->setCellValue([$c++, $row], $r['nip'] ?: '-');
            $sheet->setCellValue([$c++, $row], $r['pangkat'] ?: '-');
            $sheet->setCellValue([$c++, $row], $r['jabatan'] ?: '-');
            $sheet->setCellValue([$c++, $row], $r['jumlah_sppd']);
            $sheet->setCellValue([$c++, $row], $r['jumlah_hari']);
            $sheet->setCellValue([$c++, $row], $r['total_biaya']);
        } elseif ($jenis === 'tujuan') {
            $sheet->setCellValue([$c++, $row], $r['provinsi']);
            $sheet->setCellValue([$c++, $row], $r['jumlah_sppd']);
            $sheet->setCellValue([$c++, $row], $r['jumlah_hari']);
            $sheet->setCellValue([$c++, $row], $r['total_biaya']);
        } elseif ($jenis === 'status') {
            $sheet->setCellValue([$c++, $row], $r['jumlah_sppd']);
            $sheet->setCellValue([$c++, $row], $r['jumlah_hari']);
            $sheet->setCellValue([$c++, $row], $r['total_biaya']);
        }
        $sheet->getStyle([1, $row, $c - 1, $row])->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);
        $sheet->getStyle([$c - 1, $row])->getNumberFormat()->setFormatCode('#,##0');
    }

    private function writeExcelTotals($sheet, string $jenis, array $data, int $row, int $lastCol): void
    {
        $label = ($data['grand_jumlah'] ?? 0).' SPPD / '.($data['grand_hari'] ?? 0).' hari';
        $sheet->setCellValue([1, $row], 'Total: '.$label);
        $sheet->mergeCells([1, $row, $lastCol - 1, $row]);
        $sheet->setCellValue([$lastCol, $row], $data['grand_total']);
        $sheet->getStyle([1, $row, $lastCol, $row])->getFont()->setBold(true);
        $sheet->getStyle([1, $row, $lastCol, $row])->getBorders()->getAllBorders()->setBorderStyle(Border::BORDER_THIN);
        $sheet->getStyle([$lastCol, $row])->getNumberFormat()->setFormatCode('#,##0');
    }

    private function tanggalIndo($date): string
    {
        $bulan = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
        $d = Carbon::parse($date);

        return $d->format('d').' '.$bulan[(int) $d->format('n')].' '.$d->format('Y');
    }

    public function generateNomor(): string
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
        if ($angka < 12) {
            return $huruf[$angka];
        }
        if ($angka < 20) {
            return $huruf[$angka - 10].' belas';
        }
        if ($angka < 100) {
            $x = intdiv($angka, 10);
            $sisa = $angka % 10;

            return ($x == 1 ? 'se' : $huruf[$x].' ').'puluh'.($sisa > 0 ? ' '.$huruf[$sisa] : '');
        }
        if ($angka < 200) {
            return 'seratus '.$this->terbilang($angka - 100);
        }
        if ($angka < 1000) {
            $x = intdiv($angka, 100);
            $sisa = $angka % 100;

            return $huruf[$x].' ratus'.($sisa > 0 ? ' '.$this->terbilang($sisa) : '');
        }
        if ($angka < 2000) {
            return 'seribu '.$this->terbilang($angka - 1000);
        }
        if ($angka < 1000000) {
            $x = intdiv($angka, 1000);
            $sisa = $angka % 1000;

            return $this->terbilang($x).' ribu'.($sisa > 0 ? ' '.$this->terbilang($sisa) : '');
        }
        if ($angka < 1000000000) {
            $x = intdiv($angka, 1000000);
            $sisa = $angka % 1000000;

            return $this->terbilang($x).' juta'.($sisa > 0 ? ' '.$this->terbilang($sisa) : '');
        }

        return (string) $angka;
    }
}
