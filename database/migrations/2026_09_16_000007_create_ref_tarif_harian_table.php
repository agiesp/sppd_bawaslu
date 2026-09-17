<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ref_tarif_harian', function (Blueprint $table) {
            $table->id();
            $table->integer('id_provinsi');
            $table->integer('luar_kota')->default(0);
            $table->integer('dalam_kota_lebih_8_jam')->default(0);
            $table->integer('diklat')->default(0);
            $table->foreign('id_provinsi')->references('id_provinsi')->on('ref_provinsi');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ref_tarif_harian');
    }
};