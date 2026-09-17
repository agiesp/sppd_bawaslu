<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ref_tarif_pesawat', function (Blueprint $table) {
            $table->id();
            $table->string('kota_asal', 100);
            $table->string('kota_tujuan', 100);
            $table->integer('tarif_bisnis')->default(0);
            $table->integer('tarif_ekonomi')->default(0);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ref_tarif_pesawat');
    }
};