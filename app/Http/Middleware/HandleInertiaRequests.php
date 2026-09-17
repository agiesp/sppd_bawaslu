<?php

namespace App\Http\Middleware;

use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    protected $rootView = 'app';

    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    public function share(Request $request): array
    {
        return [
            ...parent::share($request),
            'auth' => [
                'user' => $request->user() ? [
                    'id' => $request->user()->id,
                    'name' => $request->user()->name,
                    'email' => $request->user()->email,
                    'role' => $request->user()->role?->name,
                    'avatar_url' => $request->user()->avatar_url,
                ] : null,
            ],
            'flash' => [
                'success' => $request->session()->get('success'),
            ],
            'menus' => $this->getAccessibleMenus($request),
            'appSettings' => $this->getAppSettings(),
            'permissions' => $this->getUserPermissions($request),
        ];
    }

    private function getUserPermissions(Request $request): array
    {
        $user = $request->user();

        if (! $user || ! $user->role_id) {
            return [];
        }

        $rows = \DB::table('role_permissions')
            ->join('ref_menu', 'role_permissions.menu_id', '=', 'ref_menu.id')
            ->where('role_permissions.role_id', $user->role_id)
            ->whereNotNull('ref_menu.url')
            ->get([
                'ref_menu.url',
                'role_permissions.can_view',
                'role_permissions.can_create',
                'role_permissions.can_edit',
                'role_permissions.can_delete',
            ]);

        $permissions = [];
        foreach ($rows as $row) {
            $permissions[$row->url] = [
                'can_view' => (bool) $row->can_view,
                'can_create' => (bool) $row->can_create,
                'can_edit' => (bool) $row->can_edit,
                'can_delete' => (bool) $row->can_delete,
            ];
        }
        return $permissions;
    }

    private function getAppSettings(): array
    {
        return \App\Models\Setting::where('is_active', true)
            ->pluck('value', 'key')
            ->toArray();
    }

    private function getAccessibleMenus(Request $request): array
    {
        $user = $request->user();
        if (!$user) return [];

        $roleId = $user->role_id;
        if (!$roleId) return [];

        $allowedMenuIds = \DB::table('role_permissions')
            ->where('role_id', $roleId)
            ->where('can_view', true)
            ->pluck('menu_id')
            ->all();

        if (empty($allowedMenuIds)) return [];

        $allMenus = \App\Models\RefMenu::where('is_active', true)
            ->orderBy('order')
            ->get()
            ->keyBy('id');

        $allowedSet = array_flip($allowedMenuIds);

        $build = function (int $parentId = 0) use (&$build, $allMenus, $allowedSet): array {
            $children = $allMenus
                ->where('parent_id', $parentId === 0 ? null : $parentId)
                ->filter(fn ($menu) => isset($allowedSet[$menu->id]));

            return $children->map(function ($menu) use (&$build) {
                return [
                    'id' => $menu->id,
                    'name' => $menu->name,
                    'icon' => $menu->icon,
                    'url' => $menu->url,
                    'children' => $build($menu->id),
                ];
            })->values()->all();
        };

        return $build(0);
    }
}