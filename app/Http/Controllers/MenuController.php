<?php

namespace App\Http\Controllers;

use App\Models\RefMenu;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class MenuController extends Controller
{
    public function index(): Response
    {
        $menus = RefMenu::with('children')->whereNull('parent_id')->orderBy('order')->get();
        return Inertia::render('Menus/Index', ['menus' => $menus]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:100',
            'icon' => 'nullable|string',
            'url' => 'nullable|string',
            'parent_id' => 'nullable|integer|exists:ref_menu,id',
            'order' => 'integer|min:0',
        ]);
        $validated['is_active'] = true;
        $menu = RefMenu::create($validated);
        return response()->json(['message' => 'Menu berhasil ditambahkan.', 'menu' => $menu], 201);
    }

    public function update(Request $request, RefMenu $menu)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:100',
            'icon' => 'nullable|string',
            'url' => 'nullable|string',
            'parent_id' => 'nullable|integer|exists:ref_menu,id',
            'order' => 'integer|min:0',
            'is_active' => 'boolean',
        ]);
        $menu->update($validated);
        return response()->json(['message' => 'Menu berhasil diperbarui.', 'menu' => $menu]);
    }

    public function destroy(RefMenu $menu)
    {
        $menu->delete();
        return response()->json(['message' => 'Menu berhasil dihapus.']);
    }
}