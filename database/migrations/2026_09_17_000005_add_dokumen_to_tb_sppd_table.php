<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->string('file_surat_tugas', 255)->nullable()->after('kota_tujuan_pesawat');
            $table->string('file_sppd', 255)->nullable()->after('file_surat_tugas');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->dropColumn(['file_surat_tugas', 'file_sppd']);
        });
    }
};
