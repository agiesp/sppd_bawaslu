<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Inertia\Response;

class DashboardController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Dashboard');
    }

    public function metrics(Request $request): JsonResponse
    {
        $totalSppd = DB::table('tb_sppd')->count();
        $draft = DB::table('tb_sppd')->where('status', 'draft')->count();
        $proses = DB::table('tb_sppd')->where('status', 'proses')->count();
        $selesai = DB::table('tb_sppd')->where('status', 'selesai')->count();
        $totalBiaya = DB::table('tb_sppd')->sum('total_biaya');

        $recentSppd = DB::table('tb_sppd')
            ->orderBy('created_at', 'desc')
            ->limit(5)
            ->get()
            ->map(fn ($r) => [
                'id' => $r->id,
                'nomor_sppd' => $r->nomor_sppd,
                'atas_nama' => $r->atas_nama,
                'tujuan_daerah' => $r->tujuan_daerah,
                'tanggal_mulai' => $r->tanggal_mulai,
                'status' => $r->status,
                'total_biaya' => $r->total_biaya,
            ]);

        return response()->json([
            'total_sppd' => $totalSppd,
            'draft' => $draft,
            'proses' => $proses,
            'selesai' => $selesai,
            'total_biaya' => $totalBiaya,
            'recent_sppd' => $recentSppd,
        ]);
    }
}