<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $rows = [
            [
                'group' => 'cetak',
                'key' => 'print_ppk_nama',
                'value' => 'FAUZI, S.Sos',
                'label' => 'Nama Pejabat Pembuat Komitmen',
                'type' => 'text',
                'order' => 1,
                'is_active' => true,
            ],
            [
                'group' => 'cetak',
                'key' => 'print_ppk_nip',
                'value' => '19801231 199905 1 002',
                'label' => 'NIP Pejabat Pembuat Komitmen',
                'type' => 'text',
                'order' => 2,
                'is_active' => true,
            ],
            [
                'group' => 'cetak',
                'key' => 'print_bendahara_nama',
                'value' => 'MUSLIM',
                'label' => 'Nama Bendahara Pengeluaran Pembantu',
                'type' => 'text',
                'order' => 3,
                'is_active' => true,
            ],
            [
                'group' => 'cetak',
                'key' => 'print_bendahara_nip',
                'value' => '19840105 201001 1 005',
                'label' => 'NIP Bendahara Pengeluaran Pembantu',
                'type' => 'text',
                'order' => 4,
                'is_active' => true,
            ],
        ];

        foreach ($rows as $row) {
            if (! DB::table('settings')->where('key', $row['key'])->exists()) {
                DB::table('settings')->insert($row);
            }
        }
    }

    public function down(): void
    {
        DB::table('settings')->whereIn(
            'key',
            ['print_ppk_nama', 'print_ppk_nip', 'print_bendahara_nama', 'print_bendahara_nip'],
        )->delete();
    }
};