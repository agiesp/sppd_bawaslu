<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class RoleMenuSeeder extends Seeder
{
    public function run(): void
    {
        // Settings
        DB::table('settings')->insert([
            ['key' => 'app_name', 'value' => 'SPPD Bawaslu', 'is_active' => true],
            ['key' => 'app_favicon', 'value' => null, 'is_active' => true],
        ]);

        // Roles
        $roles = [
            ['name' => 'Admin', 'description' => 'Administrator penuh'],
            ['name' => 'Operator', 'description' => 'Operator SPPD'],
            ['name' => 'PPK', 'description' => 'Pejabat Pembuat Komitmen'],
            ['name' => 'Bendahara', 'description' => 'Bendahara Pengeluaran'],
        ];
        foreach ($roles as $r) {
            DB::table('roles')->insert($r);
        }

        // Menus
        $menuIds = [];
        $parents = [
            ['name' => 'SPPD', 'icon' => 'DocsIcon', 'order' => 2],
            ['name' => 'Referensi', 'icon' => 'FolderIcon', 'order' => 3],
            ['name' => 'Master', 'icon' => 'ArchiveIcon', 'order' => 4],
            ['name' => 'Pengaturan', 'icon' => 'SettingsIcon', 'order' => 5],
        ];
        foreach ($parents as $p) {
            $id = DB::table('ref_menu')->insertGetId([
                'name' => $p['name'], 'icon' => $p['icon'], 'url' => null,
                'parent_id' => null, 'order' => $p['order'], 'is_active' => true,
            ]);
            $menuIds[$p['name']] = $id;
        }

        $items = [
            ['name' => 'Dashboard', 'icon' => 'LayoutDashboardIcon', 'url' => '/dashboard', 'parent' => null, 'order' => 1],
            ['name' => 'Buat SPPD', 'icon' => null, 'url' => '/sppd/buat', 'parent' => 'SPPD', 'order' => 1],
            ['name' => 'Daftar SPPD', 'icon' => null, 'url' => '/sppd', 'parent' => 'SPPD', 'order' => 2],
            ['name' => 'Data Tarif', 'icon' => null, 'url' => '/admin/referensi', 'parent' => 'Referensi', 'order' => 1],
            ['name' => 'Pegawai', 'icon' => null, 'url' => '/admin/master/pegawai', 'parent' => 'Master', 'order' => 1],
            ['name' => 'Users', 'icon' => null, 'url' => '/users', 'parent' => 'Pengaturan', 'order' => 1],
            ['name' => 'Roles', 'icon' => null, 'url' => '/roles', 'parent' => 'Pengaturan', 'order' => 2],
            ['name' => 'Menus', 'icon' => null, 'url' => '/menus', 'parent' => 'Pengaturan', 'order' => 3],
            ['name' => 'Pengaturan Sistem', 'icon' => 'SupportIcon', 'url' => '/admin/system', 'parent' => null, 'order' => 6],
        ];
        foreach ($items as $it) {
            $id = DB::table('ref_menu')->insertGetId([
                'name' => $it['name'], 'icon' => $it['icon'], 'url' => $it['url'],
                'parent_id' => $it['parent'] ? $menuIds[$it['parent']] : null,
                'order' => $it['order'], 'is_active' => true,
            ]);
            $menuIds[$it['name']] = $id;
        }

        // Admin gets all permissions
        $allMenus = DB::table('ref_menu')->get();
        foreach ($allMenus as $menu) {
            DB::table('role_permissions')->insert([
                'role_id' => 1,
                'menu_id' => $menu->id,
                'can_view' => true,
                'can_create' => true,
                'can_edit' => true,
                'can_delete' => true,
            ]);
        }

        // Operator: view SPPD, create/edit SPPD, view Pegawai, create/edit Pegawai
        $operatorPerms = [
            '/sppd' => ['can_view', 'can_create', 'can_edit'],
            '/sppd/buat' => ['can_view', 'can_create'],
            '/admin/master/pegawai' => ['can_view', 'can_create', 'can_edit'],
            '/admin/referensi' => ['can_view'],
        ];
        $this->assignPermissions(2, $operatorPerms);

        // PPK: view SPPD, edit SPPD (approve)
        $ppkPerms = ['/sppd' => ['can_view', 'can_edit'], '/sppd/buat' => ['can_view']];
        $this->assignPermissions(3, $ppkPerms);

        // Bendahara: view SPPD only
        $bendaharaPerms = ['/sppd' => ['can_view'], '/sppd/buat' => ['can_view']];
        $this->assignPermissions(4, $bendaharaPerms);

        // Admin user
        DB::table('users')->insert([
            'name' => 'Administrator',
            'email' => 'admin@bawaslu-pidie.go.id',
            'password' => Hash::make('password'),
            'role_id' => 1,
        ]);
    }

    private function assignPermissions(int $roleId, array $perms): void
    {
        foreach ($perms as $url => $actions) {
            $menu = DB::table('ref_menu')->where('url', $url)->first();
            if (!$menu) continue;
            DB::table('role_permissions')->insert([
                'role_id' => $roleId,
                'menu_id' => $menu->id,
                'can_view' => in_array('can_view', $actions),
                'can_create' => in_array('can_create', $actions),
                'can_edit' => in_array('can_edit', $actions),
                'can_delete' => in_array('can_delete', $actions),
            ]);
        }
    }
}