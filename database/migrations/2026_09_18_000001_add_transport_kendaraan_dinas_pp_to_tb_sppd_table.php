<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->boolean('transport_kendaraan_dinas_pp')->default(false)->after('taksi_bandara');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->dropColumn('transport_kendaraan_dinas_pp');
        });
    }
};
