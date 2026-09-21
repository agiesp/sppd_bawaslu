<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $rows = [
            ['group' => 'general', 'key' => 'list_tahun', 'value' => '2026,2027', 'label' => 'Daftar Tahun', 'type' => 'text', 'order' => 6, 'is_active' => true],
            ['group' => 'general', 'key' => 'default_tahun', 'value' => '2026', 'label' => 'Tahun Default', 'type' => 'text', 'order' => 7, 'is_active' => true],
        ];

        foreach ($rows as $row) {
            if (! DB::table('settings')->where('key', $row['key'])->exists()) {
                DB::table('settings')->insert($row);
            }
        }
    }

    public function down(): void
    {
        DB::table('settings')->whereIn('key', ['list_tahun', 'default_tahun'])->delete();
    }
};