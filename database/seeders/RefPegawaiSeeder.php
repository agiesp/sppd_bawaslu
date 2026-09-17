<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RefPegawaiSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            ['Fauzi, S.H., M.H.', '197501012000031001', 'Pembina Tk. I / IV-b', 'Ketua Bawaslu Kab. Pidie'],
            ['Cut Nurul Husna, S.T.', '198103152004122002', 'Pembina / IV-a', 'Anggota Bawaslu Kab. Pidie'],
            ['Teuku Ilhamsyah, S.IP.', '198506122009011003', 'Penata Tk. I / III-d', 'Sekretaris Bawaslu Kab. Pidie'],
            ['Rahmad Hidayat, S.E.', '199002032014031004', 'Penata Muda Tk. I / III-b', 'Bendahara Pengeluaran'],
            ['Muliadi, S.Kom.', '199304182019031006', 'Pengatur / II-c', 'Staf Sekretariat'],
        ];

        foreach ($data as $d) {
            DB::table('ref_pegawai')->insert([
                'nama_pegawai' => $d[0],
                'nip' => $d[1],
                'pangkat_golongan' => $d[2],
                'jabatan' => $d[3],
            ]);
        }
    }
}