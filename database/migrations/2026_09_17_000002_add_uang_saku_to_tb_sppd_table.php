<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->unsignedBigInteger('uang_saku')->default(0)->after('kota_tujuan_pesawat');
            $table->integer('uang_saku_hari')->default(0)->after('uang_saku');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->dropColumn(['uang_saku', 'uang_saku_hari']);
        });
    }
};