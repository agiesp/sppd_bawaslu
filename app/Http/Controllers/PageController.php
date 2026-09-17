<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class PageController extends Controller
{
    private function resolveName(string $path): ?string
    {
        $segments = array_values(array_filter(explode('/', $path)));
        if (empty($segments)) return 'Dashboard';

        $first = $segments[0];

        $map = [
            'dashboard' => 'Dashboard',
            'signin' => 'Auth/Signin',
            'signup' => 'Auth/Signup',
            'users' => 'Users/Index',
            'roles' => 'Roles/Index',
            'menus' => 'Menus/Index',
            'sppd' => 'Sppd/Index',
        ];

        if (isset($map[$path])) return $map[$path];
        if (isset($map[$first])) return $map[$first];

        $adminMap = [
            'admin/referensi' => 'Referensi/Index',
            'admin/master/pegawai' => 'Master/Pegawai',
        ];

        if (isset($adminMap[$path])) return $adminMap[$path];

        return null;
    }

    public function show(Request $request): Response
    {
        $name = $this->resolveName($request->path());
        if (!$name) abort(404);
        return Inertia::render($name);
    }
}