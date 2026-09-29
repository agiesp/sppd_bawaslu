<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd_rincian', function (Blueprint $table) {
            $table->string('maskapai', 100)->nullable()->after('bukti');
            $table->string('no_booking', 50)->nullable()->after('maskapai');
            $table->string('no_tiket', 50)->nullable()->after('no_booking');
            $table->string('no_penerbangan', 30)->nullable()->after('no_tiket');
            $table->string('nama_hotel', 100)->nullable()->after('no_penerbangan');
            $table->string('no_kamar', 30)->nullable()->after('nama_hotel');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd_rincian', function (Blueprint $table) {
            $table->dropColumn(['maskapai', 'no_booking', 'no_tiket', 'no_penerbangan', 'nama_hotel', 'no_kamar']);
        });
    }
};