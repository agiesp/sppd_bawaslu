<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RefTarifTransportProvinsiSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            [1, 123000],
            [2, 278000],
            [3, 99000],
            [4, 159000],
            [5, 133000],
            [6, 171000],
            [7, 162000],
            [8, 162000],
            [9, 106000],
            [10, 94000],
            [11, 300000],
            [12, 180000],
            [13, 250000],
            [14, 105000],
            [15, 258000],
            [16, 225000],
            [17, 219000],
            [18, 224000],
            [19, 105000],
            [20, 165000],
            [21, 130000],
            [22, 174000],
            [23, 300000],
            [24, 211000],
            [25, 134000],
            [26, 256000],
            [27, 283000],
            [28, 181000],
            [29, 149000],
            [30, 154000],
            [31, 279000],
            [32, 208000],
            [33, 462000],
            [34, 228000],
        ];

        foreach ($data as [$provinsi, $besaran]) {
            DB::table('ref_tarif_transport_provinsi')->insert([
                'id_provinsi' => $provinsi,
                'besaran' => $besaran,
            ]);
        }
    }
}