<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Inertia\Response;
use App\Models\Sppd;

class DashboardController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Dashboard');
    }

    public function metrics(Request $request): JsonResponse
    {
        $totalSppd = Sppd::count();
        $draft = Sppd::where('status', 'draft')->count();
        $proses = Sppd::where('status', 'proses')->count();
        $selesai = Sppd::where('status', 'selesai')->count();
        $totalBiaya = (int) Sppd::sum('total_biaya');

        $sppdAsn = Sppd::whereHas('pegawai', fn ($q) => $q->where('tipe', 'pegawai'))->count();
        $sppdKomisioner = Sppd::whereHas('pegawai', fn ($q) => $q->where('tipe', 'komisioner'))->count();
        $sppdDalam = Sppd::where('jenis_sppd', 'dalam')->count();
        $sppdLuar = Sppd::where('jenis_sppd', 'luar')->count();

        $recentSppd = Sppd::orderBy('created_at', 'desc')
            ->limit(5)
            ->get()
            ->map(fn (Sppd $r) => [
                'id' => $r->id,
                'nomor_sppd' => $r->nomor_sppd,
                'atas_nama' => $r->atas_nama,
                'tujuan_daerah' => $r->tujuan_daerah,
                'tanggal_mulai' => $r->tanggal_mulai->format('Y-m-d'),
                'status' => $r->status,
                'total_biaya' => $r->total_biaya,
            ]);

        $asnAvatars = Sppd::with('pegawai')
            ->whereHas('pegawai', fn ($q) => $q->where('tipe', 'pegawai'))
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(fn (Sppd $s) => [
                'name' => $s->pegawai->nama_pegawai ?? $s->atas_nama,
                'avatar_url' => $s->pegawai->avatar_url,
            ])
            ->unique('name')
            ->take(6)
            ->values();

        $komisionerAvatars = Sppd::with('pegawai')
            ->whereHas('pegawai', fn ($q) => $q->where('tipe', 'komisioner'))
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(fn (Sppd $s) => [
                'name' => $s->pegawai->nama_pegawai ?? $s->atas_nama,
                'avatar_url' => $s->pegawai->avatar_url,
            ])
            ->unique('name')
            ->take(6)
            ->values();

        return response()->json([
            'total_sppd' => $totalSppd,
            'draft' => $draft,
            'proses' => $proses,
            'selesai' => $selesai,
            'total_biaya' => $totalBiaya,
            'sppd_asn' => $sppdAsn,
            'sppd_komisioner' => $sppdKomisioner,
            'sppd_dalam' => $sppdDalam,
            'sppd_luar' => $sppdLuar,
            'asn_avatars' => $asnAvatars,
            'komisioner_avatars' => $komisionerAvatars,
            'recent_sppd' => $recentSppd,
        ]);
    }

    public function schedule(Request $request): JsonResponse
    {
        $year = $request->input('tahun', date('Y'));

        $sppdList = Sppd::with('pegawai')
            ->where(function ($q) use ($year) {
                $q->whereYear('tanggal_mulai', $year)
                    ->orWhereYear('tanggal_selesai', $year);
            })
            ->orderBy('tanggal_mulai')
            ->get()
            ->map(fn (Sppd $s) => [
                'id' => $s->id,
                'nomor_sppd' => $s->nomor_sppd,
                'atas_nama' => $s->atas_nama,
                'keperluan' => $s->keperluan,
                'tujuan_daerah' => $s->tujuan_daerah,
                'status' => $s->status,
                'tanggal_mulai' => $s->tanggal_mulai->format('Y-m-d'),
                'tanggal_selesai' => $s->tanggal_selesai->format('Y-m-d'),
                'lama_hari' => $s->lama_hari,
                'avatar_url' => $s->pegawai?->avatar_url,
            ]);

        return response()->json(['schedules' => $sppdList->values()]);
    }

    public function financing(Request $request): JsonResponse
    {
        $year = (int) $request->input('tahun', date('Y'));

        $sppdList = Sppd::with(['pegawai', 'rincian'])
            ->where('tahun', $year)
            ->get();

        $asn = array_fill(0, 12, 0);
        $komisioner = array_fill(0, 12, 0);

        foreach ($sppdList as $sppd) {
            $tipe = $sppd->pegawai?->tipe;

            $rincianTotal = (int) $sppd->rincian->sum('jumlah');
            $total = $rincianTotal > 0 ? $rincianTotal : (int) $sppd->total_biaya;

            $month = (int) $sppd->tanggal_mulai->format('n') - 1;

            if ($tipe === 'pegawai') {
                $asn[$month] += $total;
            } elseif ($tipe === 'komisioner') {
                $komisioner[$month] += $total;
            }
        }

        $toJuta = fn (array $values) => array_map(
            fn ($v) => round($v / 1_000_000, 1),
            $values,
        );

        return response()->json([
            'year' => $year,
            'series' => [
                ['name' => 'ASN', 'data' => $toJuta($asn)],
                ['name' => 'Komisioner', 'data' => $toJuta($komisioner)],
            ],
        ]);
    }

    public function notifications(Request $request): JsonResponse
    {
        $today = now()->toDateString();

        $list = Sppd::with('pegawai')
            ->whereDate('tanggal_mulai', '<=', $today)
            ->whereDate('tanggal_selesai', '>=', $today)
            ->where('status', '!=', 'batal')
            ->orderBy('tanggal_mulai')
            ->get()
            ->map(fn (Sppd $s) => [
                'id' => $s->id,
                'nomor_sppd' => $s->nomor_sppd,
                'atas_nama' => $s->atas_nama,
                'keperluan' => $s->keperluan,
                'tujuan_daerah' => $s->tujuan_daerah,
                'status' => $s->status,
                'tanggal_mulai' => $s->tanggal_mulai->format('Y-m-d'),
                'tanggal_selesai' => $s->tanggal_selesai->format('Y-m-d'),
                'avatar_url' => $s->pegawai?->avatar_url,
            ]);

        return response()->json([
            'notifications' => $list->values(),
            'total' => $list->count(),
        ]);
    }
}