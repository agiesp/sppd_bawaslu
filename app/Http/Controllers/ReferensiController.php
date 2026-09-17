<?php

namespace App\Http\Controllers;

use App\Models\RefProvinsi;
use App\Models\RefTarifHarian;
use App\Models\RefTarifPenginapan;
use App\Models\RefTarifPesawat;
use App\Models\RefTarifTransportDarat;
use App\Models\RefTarifTransportProvinsi;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class ReferensiController extends Controller
{
    public function index(): Response
    {
        return Inertia::render('Referensi/Index', [
            'data' => [
                'tarif_harian' => RefTarifHarian::with('provinsi')->orderBy('id_provinsi')->get(),
                'tarif_penginapan' => RefTarifPenginapan::with('provinsi')->orderBy('id_provinsi')->get(),
                'tarif_pesawat' => RefTarifPesawat::orderBy('kota_asal')->orderBy('kota_tujuan')->get(),
                'tarif_transport_darat' => RefTarifTransportDarat::orderBy('ibukota_provinsi')->orderBy('kabupaten_kota_tujuan')->get(),
                'tarif_transport_provinsi' => RefTarifTransportProvinsi::with('provinsi')->orderBy('id_provinsi')->get(),
            ],
        ]);
    }

    public function updateTarifHarian(Request $request, RefTarifHarian $tarif)
    {
        $validated = $request->validate([
            'luar_kota' => 'required|integer|min:0',
            'dalam_kota_lebih_8_jam' => 'required|integer|min:0',
            'diklat' => 'required|integer|min:0',
        ]);
        $tarif->update($validated);
        return response()->json(['message' => 'Tarif harian berhasil diperbarui.', 'data' => $tarif->fresh('provinsi')]);
    }

    public function updateTarifPenginapan(Request $request, RefTarifPenginapan $tarif)
    {
        $validated = $request->validate([
            'pejabat_negara_eselon_1' => 'required|integer|min:0',
            'pejabat_lainnya_eselon_2' => 'required|integer|min:0',
            'eselon_3_gol_4' => 'required|integer|min:0',
            'eselon_4_gol_3_2_1' => 'required|integer|min:0',
        ]);
        $tarif->update($validated);
        return response()->json(['message' => 'Tarif penginapan berhasil diperbarui.', 'data' => $tarif->fresh('provinsi')]);
    }

    public function updateTarifPesawat(Request $request, RefTarifPesawat $tarif)
    {
        $validated = $request->validate([
            'tarif_bisnis' => 'required|integer|min:0',
            'tarif_ekonomi' => 'required|integer|min:0',
        ]);
        $tarif->update($validated);
        return response()->json(['message' => 'Tarif pesawat berhasil diperbarui.', 'data' => $tarif->fresh()]);
    }

    public function updateTarifTransportDarat(Request $request, RefTarifTransportDarat $tarif)
    {
        $validated = $request->validate([
            'besaran' => 'required|integer|min:0',
        ]);
        $tarif->update($validated);
        return response()->json(['message' => 'Tarif transport darat berhasil diperbarui.', 'data' => $tarif->fresh()]);
    }

    public function updateTarifTransportProvinsi(Request $request, RefTarifTransportProvinsi $tarif)
    {
        $validated = $request->validate([
            'besaran' => 'required|integer|min:0',
        ]);
        $tarif->update($validated);
        return response()->json(['message' => 'Tarif transport provinsi berhasil diperbarui.', 'data' => $tarif->fresh('provinsi')]);
    }
}