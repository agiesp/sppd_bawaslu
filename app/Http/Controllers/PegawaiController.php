<?php

namespace App\Http\Controllers;

use App\Models\Pegawai;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;

class PegawaiController extends Controller
{
    public function index(): Response
    {
        $pegawais = Pegawai::orderBy('nama_pegawai')->get();
        return Inertia::render('Master/Pegawai', ['pegawais' => $pegawais]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nama_pegawai' => 'required|string|max:150',
            'nip' => 'nullable|string|max:30',
            'pangkat_golongan' => 'nullable|string|max:50',
            'jabatan' => 'nullable|string|max:100',
            'tipe' => 'required|in:pegawai,komisioner',
            'avatar' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
        ]);
        if ($request->hasFile('avatar')) {
            $validated['avatar'] = $request->file('avatar')->store('avatars', 'public');
        }
        $pegawai = Pegawai::create($validated);
        return response()->json(['message' => 'Pegawai berhasil ditambahkan.', 'pegawai' => $pegawai], 201);
    }

    public function update(Request $request, int $id)
    {
        $pegawai = Pegawai::findOrFail($id);

        $validated = $request->validate([
            'nama_pegawai' => 'required|string|max:150',
            'nip' => 'nullable|string|max:30',
            'pangkat_golongan' => 'nullable|string|max:50',
            'jabatan' => 'nullable|string|max:100',
            'tipe' => 'required|in:pegawai,komisioner',
            'avatar' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
        ]);
        if ($request->hasFile('avatar')) {
            if ($pegawai->avatar) {
                Storage::disk('public')->delete($pegawai->avatar);
            }
            $validated['avatar'] = $request->file('avatar')->store('avatars', 'public');
        }
        $pegawai->update($validated);
        return response()->json(['message' => 'Pegawai berhasil diperbarui.', 'pegawai' => $pegawai]);
    }

    public function destroy(int $id)
    {
        $pegawai = Pegawai::findOrFail($id);
        if ($pegawai->avatar) {
            Storage::disk('public')->delete($pegawai->avatar);
        }
        $pegawai->delete();
        return response()->json(['message' => 'Pegawai berhasil dihapus.']);
    }
}