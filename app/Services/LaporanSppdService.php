<?php

namespace App\Services;

use App\Models\Sppd;
use Illuminate\Support\Collection;

class LaporanSppdService
{
    public const JENIS = [
        'rekap' => 'Rekap / Register SPPD',
        'rincian' => 'Rincian Biaya per SPPD',
        'pegawai' => 'Rekap Biaya per Pegawai',
        'tujuan' => 'Rekap Biaya per Tujuan / Provinsi',
        'status' => 'Rekap Berdasarkan Status',
    ];

    public const STATUS_LABEL = [
        'draft' => 'Draft',
        'proses' => 'Proses',
        'selesai' => 'Selesai',
        'batal' => 'Batal',
    ];

    public function isJenisValid(?string $jenis): bool
    {
        return $jenis !== null && isset(self::JENIS[$jenis]);
    }

    public function namaLaporan(?string $jenis): string
    {
        return self::JENIS[$jenis] ?? '';
    }

    public function filteredSppd(?string $awal, ?string $akhir): Collection
    {
        $q = Sppd::with(['provinsi', 'pegawai']);

        if ($awal && $akhir) {
            $q->where(function ($q) use ($awal, $akhir) {
                $q->whereBetween('tanggal_mulai', [$awal, $akhir])
                    ->orWhereBetween('tanggal_selesai', [$awal, $akhir])
                    ->orWhere(function ($q) use ($awal, $akhir) {
                        $q->where('tanggal_mulai', '<=', $awal)
                            ->where('tanggal_selesai', '>=', $akhir);
                    });
            });
        } elseif ($awal) {
            $q->where('tanggal_mulai', '>=', $awal);
        } elseif ($akhir) {
            $q->where('tanggal_mulai', '<=', $akhir);
        }

        return $q->orderBy('tanggal_mulai')->get();
    }

    public function data(string $jenis, ?string $awal, ?string $akhir, ?string $nomor = null): array
    {
        $awal = $awal ?: null;
        $akhir = $akhir ?: null;

        return match ($jenis) {
            'rekap' => $this->dataRekap($awal, $akhir),
            'rincian' => $this->dataRincian($nomor),
            'pegawai' => $this->dataPegawai($awal, $akhir),
            'tujuan' => $this->dataTujuan($awal, $akhir),
            'status' => $this->dataStatus($awal, $akhir),
            default => throw new \InvalidArgumentException('Jenis laporan tidak dikenali.'),
        };
    }

    public function dataRekap(?string $awal, ?string $akhir): array
    {
        $rows = $this->filteredSppd($awal, $akhir)->map(function (Sppd $r) {
            return [
                'nomor_sppd' => $r->nomor_sppd,
                'atas_nama' => $r->atas_nama,
                'nip' => $r->nip,
                'jabatan' => $r->jabatan,
                'tujuan_daerah' => $r->tujuan_daerah,
                'provinsi' => $r->provinsi ? $r->provinsi->nama_provinsi : '-',
                'tanggal_mulai' => $r->tanggal_mulai->format('Y-m-d'),
                'tanggal_selesai' => $r->tanggal_selesai->format('Y-m-d'),
                'lama_hari' => $r->lama_hari,
                'status' => self::STATUS_LABEL[$r->status] ?? $r->status,
                'total_biaya' => (int) $r->total_biaya,
            ];
        })->values();

        return [
            'jenis' => 'rekap',
            'rows' => $rows,
            'grand_jumlah' => $rows->count(),
            'grand_hari' => $rows->sum('lama_hari'),
            'grand_total' => $rows->sum('total_biaya'),
        ];
    }

    public function dataRincian(?string $nomor): array
    {
        $sppd = null;
        if ($nomor) {
            $sppd = Sppd::with(['rincian', 'provinsi', 'pegawai', 'creator', 'approver', 'payer'])
                ->where('nomor_sppd', $nomor)
                ->first();
        }

        return [
            'jenis' => 'rincian',
            'sppd' => $sppd,
            'terbilang' => $sppd ? $this->terbilang((int) $sppd->total_biaya) : null,
        ];
    }

    public function dataPegawai(?string $awal, ?string $akhir): array
    {
        $grouped = $this->filteredSppd($awal, $akhir)
            ->groupBy(fn (Sppd $r) => $r->nip ?: '***'.$r->atas_nama);

        $rows = $grouped->map(function (Collection $g) {
            $first = $g->first();

            return [
                'nip' => $first->nip,
                'atas_nama' => $first->atas_nama,
                'pangkat' => $first->pangkat_golongan,
                'jabatan' => $first->jabatan,
                'jumlah_sppd' => $g->count(),
                'jumlah_hari' => $g->sum('lama_hari'),
                'total_biaya' => (int) $g->sum('total_biaya'),
            ];
        })->sortByDesc('total_biaya')->values();

        return [
            'jenis' => 'pegawai',
            'rows' => $rows,
            'grand_jumlah' => $rows->sum('jumlah_sppd'),
            'grand_hari' => $rows->sum('jumlah_hari'),
            'grand_total' => $rows->sum('total_biaya'),
        ];
    }

    public function dataTujuan(?string $awal, ?string $akhir): array
    {
        $grouped = $this->filteredSppd($awal, $akhir)
            ->groupBy(fn (Sppd $r) => $r->provinsi_tujuan.'|'.$r->tujuan_daerah);

        $rows = $grouped->map(function (Collection $g) {
            $first = $g->first();

            return [
                'tujuan_daerah' => $first->tujuan_daerah,
                'provinsi' => $first->provinsi ? $first->provinsi->nama_provinsi : '-',
                'jumlah_sppd' => $g->count(),
                'jumlah_hari' => $g->sum('lama_hari'),
                'total_biaya' => (int) $g->sum('total_biaya'),
            ];
        })->sortByDesc('total_biaya')->values();

        return [
            'jenis' => 'tujuan',
            'rows' => $rows,
            'grand_jumlah' => $rows->sum('jumlah_sppd'),
            'grand_hari' => $rows->sum('jumlah_hari'),
            'grand_total' => $rows->sum('total_biaya'),
        ];
    }

    public function dataStatus(?string $awal, ?string $akhir): array
    {
        $grouped = $this->filteredSppd($awal, $akhir)->groupBy('status');

        $order = ['draft', 'proses', 'selesai', 'batal'];
        $rows = collect($order)->map(function (string $status) use ($grouped) {
            $g = $grouped->get($status, collect());

            return [
                'status' => self::STATUS_LABEL[$status] ?? $status,
                'jumlah_sppd' => $g->count(),
                'jumlah_hari' => $g->sum('lama_hari'),
                'total_biaya' => (int) $g->sum('total_biaya'),
            ];
        })->values();

        return [
            'jenis' => 'status',
            'rows' => $rows,
            'grand_jumlah' => $rows->sum('jumlah_sppd'),
            'grand_hari' => $rows->sum('jumlah_hari'),
            'grand_total' => $rows->sum('total_biaya'),
        ];
    }

    public function namaFile(string $jenis, ?string $awal, ?string $akhir, ?string $nomor = null): string
    {
        if ($jenis === 'rincian') {
            $no = str_replace(['/', '\\', ' '], '-', (string) $nomor);
            $no = preg_replace('/[^a-zA-Z0-9\-.]+/', '', $no);

            return 'rincian-sppd-'.($no ?: 'kosong');
        }

        $slug = str_replace(['/', '\\', ' '], '-', strtolower($this->namaLaporan($jenis)));
        $slug = preg_replace('/[^a-z0-9\-]+/', '', $slug);
        $slug = trim(preg_replace('/-+/', '-', $slug), '-');

        $periode = $awal ?? $akhir
            ? ($awal ?? 'awal').'-sd-'.($akhir ?? 'akhir')
            : 'semua-periode';

        return $slug.'-'.$periode;
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
        if ($angka < 1000000000000) {
            $x = intdiv($angka, 1000000000);
            $sisa = $angka % 1000000000;

            return $this->terbilang($x).' miliar'.($sisa > 0 ? ' '.$this->terbilang($sisa) : '');
        }

        return (string) $angka;
    }
}
