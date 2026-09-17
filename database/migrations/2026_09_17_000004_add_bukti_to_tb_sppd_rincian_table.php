<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd_rincian', function (Blueprint $table) {
            $table->string('bukti', 255)->nullable()->after('keterangan');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd_rincian', function (Blueprint $table) {
            $table->dropColumn('bukti');
        });
    }
};
