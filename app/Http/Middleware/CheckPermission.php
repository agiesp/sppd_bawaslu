<?php

namespace App\Http\Middleware;

use App\Models\RefMenu;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpKernel\Exception\HttpException;

class CheckPermission
{
    public function handle(Request $request, Closure $next, string $spec): mixed
    {
        $user = $request->user();

        if (! $user || ! $user->role_id) {
            throw new HttpException(403, 'Akses ditolak.');
        }

        [$menuUrl, $action] = array_pad(explode(':', $spec, 2), 2, 'view');

        $menu = RefMenu::where('url', $menuUrl)->first();
        if (! $menu) {
            throw new HttpException(403, 'Akses ditolak.');
        }

        $permission = \DB::table('role_permissions')
            ->where('role_id', $user->role_id)
            ->where('menu_id', $menu->id)
            ->first();

        $column = 'can_'.$action;
        if (! $permission || empty($permission->$column)) {
            throw new HttpException(403, 'Akses ditolak.');
        }

        return $next($request);
    }
}