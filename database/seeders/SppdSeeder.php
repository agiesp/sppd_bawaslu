<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SppdSeeder extends Seeder
{
    public function run(): void
    {
        $sppd = [
            [
                'nomor_sppd'        => '005/SPPD/BAWASLU-PD/I/2026',
                'atas_nama'         => 'Fauzi, S.H., M.H.',
                'nip'               => '197501012000031001',
                'pangkat_golongan'  => 'Pembina Tk. I / IV-b',
                'jabatan'           => 'Ketua Bawaslu Kab. Pidie',
                'tanggal_mulai'     => '2026-01-12',
                'tanggal_selesai'   => '2026-01-16',
                'lama_hari'         => 5,
                'tujuan_daerah'     => 'Jakarta',
                'provinsi_tujuan'   => 13,
                'keperluan'         => 'Mengikuti Rapat Koordinasi Nasional Pengawasan Pemilu',
                'status'            => 'selesai',
                'total_biaya'       => 6150000,
                'transport_udara'   => true,
                'transport_darat_pp'=> false,
                'taksi_bandara'     => true,
                'golongan'          => 'eselon_2',
                'kota_asal_pesawat' => 'Banda Aceh',
                'kota_tujuan_pesawat' => 'Jakarta',
                'rincian'           => [
                    ['uang_harian', 'Uang harian dinas luar kota', 5, 370000, null],
                    ['penginapan', 'Sewa hotel 4 malam', 4, 500000, 'Hotel Santika Jakarta'],
                    ['transport_udara_pp', 'Tiket pesawat PP Banda Aceh - Jakarta', 1, 2000000, 'Maskapai Garuda Indonesia'],
                    ['taksi_bandara', 'Taksi bandara PP', 2, 150000, null],
                ],
            ],
            [
                'nomor_sppd'        => '008/SPPD/BAWASLU-PD/II/2026',
                'atas_nama'         => 'Cut Nurul Husna, S.T.',
                'nip'               => '198103152004122002',
                'pangkat_golongan'  => 'Pembina / IV-a',
                'jabatan'           => 'Anggota Bawaslu Kab. Pidie',
                'tanggal_mulai'     => '2026-02-10',
                'tanggal_selesai'   => '2026-02-12',
                'lama_hari'         => 3,
                'tujuan_daerah'     => 'Medan',
                'provinsi_tujuan'   => 2,
                'keperluan'         => 'Sosialisasi Pengawasan Partisipatif',
                'status'            => 'selesai',
                'total_biaya'       => 2320000,
                'transport_udara'   => false,
                'transport_darat_pp'=> true,
                'taksi_bandara'     => false,
                'golongan'          => 'eselon_3',
                'rincian'           => [
                    ['uang_harian', 'Uang harian dinas luar kota', 3, 340000, null],
                    ['penginapan', 'Sewa hotel 2 malam', 2, 450000, 'Hotel Grand Medan'],
                    ['transport_darat', 'Transport Sigli - Medan PP', 1, 400000, null],
                ],
            ],
            [
                'nomor_sppd'        => '012/SPPD/BAWASLU-PD/III/2026',
                'atas_nama'         => 'Teuku Ilhamsyah, S.IP.',
                'nip'               => '198506122009011003',
                'pangkat_golongan'  => 'Penata Tk. I / III-d',
                'jabatan'           => 'Sekretaris Bawaslu Kab. Pidie',
                'tanggal_mulai'     => '2026-03-03',
                'tanggal_selesai'   => '2026-03-04',
                'lama_hari'         => 2,
                'tujuan_daerah'     => 'Banda Aceh',
                'provinsi_tujuan'   => 1,
                'keperluan'         => 'Rapat Koordinasi Sekretariat Bawaslu Provinsi Aceh',
                'status'            => 'proses',
                'total_biaya'       => 800000,
                'transport_udara'   => false,
                'transport_darat_pp'=> true,
                'taksi_bandara'     => false,
                'golongan'          => 'eselon_3',
                'rincian'           => [
                    ['uang_harian', 'Uang harian dinas luar kota', 2, 300000, null],
                    ['transport_dinas_pp', 'Transport dinas Sigli - Banda Aceh PP', 1, 200000, null],
                ],
            ],
            [
                'nomor_sppd'        => '015/SPPD/BAWASLU-PD/III/2026',
                'atas_nama'         => 'Rahmad Hidayat, S.E.',
                'nip'               => '199002032014031004',
                'pangkat_golongan'  => 'Penata Muda Tk. I / III-b',
                'jabatan'           => 'Bendahara Pengeluaran',
                'tanggal_mulai'     => '2026-03-17',
                'tanggal_selesai'   => '2026-03-20',
                'lama_hari'         => 4,
                'tujuan_daerah'     => 'Padang',
                'provinsi_tujuan'   => 6,
                'keperluan'         => 'Bimbingan Teknis Administrasi Keuangan',
                'status'            => 'proses',
                'total_biaya'       => 6710000,
                'transport_udara'   => true,
                'transport_darat_pp'=> false,
                'taksi_bandara'     => false,
                'golongan'          => 'eselon_4',
                'kota_asal_pesawat' => 'Banda Aceh',
                'kota_tujuan_pesawat' => 'Padang',
                'rincian'           => [
                    ['uang_harian', 'Uang harian dinas luar kota', 4, 340000, null],
                    ['penginapan', 'Sewa hotel 3 malam', 3, 450000, 'Hotel Pangeran Padang'],
                    ['transport_udara_pergi', 'Tiket pesawat Banda Aceh - Padang', 1, 1800000, 'Maskapai Lion Air'],
                    ['transport_udara_pulang', 'Tiket pesawat Padang - Banda Aceh', 1, 1800000, 'Maskapai Lion Air'],
                    ['uang_saku', 'Uang saku', 4, 100000, null],
                ],
            ],
            [
                'nomor_sppd'        => '020/SPPD/BAWASLU-PD/VI/2026',
                'atas_nama'         => 'Muliadi, S.Kom.',
                'nip'               => '199304182019031006',
                'pangkat_golongan'  => 'Pengatur / II-c',
                'jabatan'           => 'Staf Sekretariat',
                'tanggal_mulai'     => '2026-06-10',
                'tanggal_selesai'   => '2026-06-10',
                'lama_hari'         => 1,
                'tujuan_daerah'     => 'Banda Aceh',
                'provinsi_tujuan'   => 1,
                'keperluan'         => 'Mengantar dokumen ke Sekretariat Bawaslu Provinsi Aceh',
                'status'            => 'draft',
                'total_biaya'       => 190000,
                'transport_udara'   => false,
                'transport_darat_pp'=> false,
                'taksi_bandara'     => false,
                'golongan'          => 'eselon_4',
                'rincian'           => [
                    ['uang_harian', 'Uang harian dalam kota lebih 8 jam', 1, 90000, null],
                    ['transport_darat', 'Transport Sigli - Banda Aceh PP', 1, 100000, null],
                ],
            ],
        ];

        $idCreate = DB::table('users')->value('id') ?? 1;

        foreach ($sppd as $d) {
            $rincian = $d['rincian'];
            unset($d['rincian']);

            $d['asal_daerah']    = 'Sigli';
            $d['keperluan']      = $d['keperluan'] ?? null;
            $d['status']         = $d['status'] ?? 'draft';
            $d['total_biaya']    = array_sum(array_map(fn ($r) => $r[2] * $r[3], $rincian));
            $d['tahun']          = (int) substr($d['tanggal_mulai'], 0, 4);
            $d['created_by']     = $idCreate;
            $d['approved_by']    = $d['status'] === 'selesai' ? $idCreate : null;
            $d['paid_by']        = $d['status'] === 'selesai' ? $idCreate : null;
            $d['created_at']     = now()->subDays(rand(1, 90));
            $d['updated_at']     = now();

            $idSppd = DB::table('tb_sppd')->insertGetId($d);

            foreach ($rincian as $r) {
                DB::table('tb_sppd_rincian')->insert([
                    'id_sppd'    => $idSppd,
                    'tahun'      => $d['tahun'],
                    'jenis_biaya'=> $r[0],
                    'uraian'     => $r[1],
                    'hari'       => $r[2],
                    'satuan'     => $r[3],
                    'jumlah'     => $r[2] * $r[3],
                    'keterangan' => $r[4],
                ]);
            }
        }
    }
}