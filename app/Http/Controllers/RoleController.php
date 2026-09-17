<?php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\RefMenu;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class RoleController extends Controller
{
    public function index(): Response
    {
        $roles = Role::with('menus')->orderBy('id')->get();
        $menus = RefMenu::with('children')->whereNull('parent_id')->orderBy('order')->get();
        return Inertia::render('Roles/Index', ['roles' => $roles, 'menus' => $menus]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:50|unique:roles,name',
            'description' => 'nullable|string',
        ]);
        $role = Role::create($validated);

        $this->syncPermissions($role, $request->input('permissions'));

        return response()->json(['message' => 'Role berhasil ditambahkan.', 'role' => $role->load('menus')], 201);
    }

    public function update(Request $request, Role $role)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:50|unique:roles,name,' . $role->id,
            'description' => 'nullable|string',
        ]);
        $role->update($validated);

        if ($request->has('permissions')) {
            $this->syncPermissions($role, $request->input('permissions'));
        }

        return response()->json(['message' => 'Role berhasil diperbarui.', 'role' => $role->load('menus')]);
    }

    public function destroy(Role $role)
    {
        $role->menus()->detach();
        $role->delete();
        return response()->json(['message' => 'Role berhasil dihapus.']);
    }

    public function savePermissions(Request $request, Role $role)
    {
        $validated = $request->validate([
            'permissions' => 'required|array',
            'permissions.*.menu_id' => 'required|integer|exists:ref_menu,id',
            'permissions.*.can_view' => 'boolean',
            'permissions.*.can_create' => 'boolean',
            'permissions.*.can_edit' => 'boolean',
            'permissions.*.can_delete' => 'boolean',
        ]);
        $this->syncPermissions($role, $validated['permissions']);
        return response()->json(['message' => 'Hak akses berhasil disimpan.']);
    }

    private function syncPermissions(Role $role, $permissions): void
    {
        $role->menus()->detach();

        if (empty($permissions) || !is_array($permissions)) {
            return;
        }

        foreach ($permissions as $perm) {
            if (empty($perm['menu_id'])) {
                continue;
            }
            $role->menus()->attach($perm['menu_id'], [
                'can_view' => $perm['can_view'] ?? false,
                'can_create' => $perm['can_create'] ?? false,
                'can_edit' => $perm['can_edit'] ?? false,
                'can_delete' => $perm['can_delete'] ?? false,
            ]);
        }
    }
}