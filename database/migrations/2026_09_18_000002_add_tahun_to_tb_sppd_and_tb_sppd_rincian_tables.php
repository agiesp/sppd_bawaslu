<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->unsignedSmallInteger('tahun')->nullable()->after('nomor_sppd');
        });

        Schema::table('tb_sppd_rincian', function (Blueprint $table) {
            $table->unsignedSmallInteger('tahun')->nullable()->after('id_sppd');
        });

        DB::statement('UPDATE tb_sppd SET tahun = YEAR(tanggal_mulai) WHERE tahun IS NULL');
        DB::statement('UPDATE tb_sppd_rincian r JOIN tb_sppd s ON s.id = r.id_sppd SET r.tahun = s.tahun WHERE r.tahun IS NULL');
    }

    public function down(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->dropColumn('tahun');
        });

        Schema::table('tb_sppd_rincian', function (Blueprint $table) {
            $table->dropColumn('tahun');
        });
    }
};