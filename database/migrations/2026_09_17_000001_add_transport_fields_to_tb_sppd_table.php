<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->boolean('transport_udara')->default(false)->after('keperluan');
            $table->boolean('transport_darat_pp')->default(false)->after('transport_udara');
            $table->boolean('taksi_bandara')->default(false)->after('transport_darat_pp');
            $table->enum('golongan', ['eselon_1', 'eselon_2', 'eselon_3', 'eselon_4'])->nullable()->after('taksi_bandara');
            $table->string('kota_asal_pesawat', 100)->nullable()->after('golongan');
            $table->string('kota_tujuan_pesawat', 100)->nullable()->after('kota_asal_pesawat');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->dropColumn(['transport_udara', 'transport_darat_pp', 'taksi_bandara', 'golongan', 'kota_asal_pesawat', 'kota_tujuan_pesawat']);
        });
    }
};