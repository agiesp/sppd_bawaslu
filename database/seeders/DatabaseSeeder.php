<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            RoleMenuSeeder::class,
            RefProvinsiSeeder::class,
            RefTarifHarianSeeder::class,
            RefTarifPenginapanSeeder::class,
            RefTarifPesawatSeeder::class,
            RefTarifTransportDaratSeeder::class,
            RefTarifTransportProvinsiSeeder::class,
            RefPegawaiSeeder::class,
            SppdSeeder::class,
        ]);
    }
}