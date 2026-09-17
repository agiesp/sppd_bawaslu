<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RefProvinsiSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            [1, 'ACEH', 'Banda Aceh'],
            [2, 'SUMATRA UTARA', 'Medan'],
            [3, 'R I A U', 'Pekanbaru'],
            [4, 'KEPULAUAN RIAU', 'Tanjung Pinang'],
            [5, 'J A M B I', 'Jambi'],
            [6, 'SUMATRA BARAT', 'Padang'],
            [7, 'SUMATRA SELATAN', 'Palembang'],
            [8, 'LAMPUNG', 'Bandar Lampung'],
            [9, 'BENGKULU', 'Bengkulu'],
            [10, 'BANGKA BELITUNG', 'Pangkal Pinang'],
            [11, 'B A N T E N', 'Serang'],
            [12, 'JAWA BARAT', 'Bandung'],
            [13, 'D.K.I. JAKARTA', 'Jakarta'],
            [14, 'JAWA TENGAH', 'Semarang'],
            [15, 'D.I. YOGYAKARTA', 'Yogyakarta'],
            [16, 'JAWA TIMUR', 'Surabaya'],
            [17, 'B A L I', 'Denpasar'],
            [18, 'NUSA TENGGARA BARAT', 'Mataram'],
            [19, 'NUSA TENGGARA TIMUR', 'Kupang'],
            [20, 'KALIMANTAN BARAT', 'Pontianak'],
            [21, 'KALIMANTAN TENGAH', 'Palangkaraya'],
            [22, 'KALIMANTAN SELATAN', 'Banjarmasin'],
            [23, 'KALIMANTAN TIMUR', 'Samarinda'],
            [24, 'KALIMANTAN UTARA', 'Tanjung Selor'],
            [25, 'SULAWESI UTARA', 'Manado'],
            [26, 'GORONTALO', 'Gorontalo'],
            [27, 'SULAWESI BARAT', 'Mamuju'],
            [28, 'SULAWESI SELATAN', 'Makassar'],
            [29, 'SULAWESI TENGAH', 'Palu'],
            [30, 'SULAWESI TENGGARA', 'Kendari'],
            [31, 'MALUKU', 'Ambon'],
            [32, 'MALUKU UTARA', 'Sofifi'],
            [33, 'P A P U A', 'Jayapura'],
            [34, 'PAPUA BARAT', 'Manokwari'],
            [35, 'PAPUA BARAT DAYA', 'Sorong'],
            [36, 'PAPUA TENGAH', 'Nabire'],
            [37, 'PAPUA SELATAN', 'Merauke'],
            [38, 'PAPUA PEGUNUNGAN', 'Wamena'],
        ];

        foreach ($data as [$id, $nama, $ibukota]) {
            DB::table('ref_provinsi')->insert([
                'id_provinsi' => $id,
                'nama_provinsi' => $nama,
                'ibukota' => $ibukota,
            ]);
        }
    }
}