<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ref_tarif_transport_darat', function (Blueprint $table) {
            $table->id();
            $table->string('ibukota_provinsi', 100);
            $table->string('kabupaten_kota_tujuan', 100);
            $table->integer('besaran')->default(0);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ref_tarif_transport_darat');
    }
};