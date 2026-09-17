<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ref_tarif_penginapan', function (Blueprint $table) {
            $table->id();
            $table->integer('id_provinsi');
            $table->integer('pejabat_negara_eselon_1')->default(0);
            $table->integer('pejabat_lainnya_eselon_2')->default(0);
            $table->integer('eselon_3_gol_4')->default(0);
            $table->integer('eselon_4_gol_3_2_1')->default(0);
            $table->foreign('id_provinsi')->references('id_provinsi')->on('ref_provinsi');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ref_tarif_penginapan');
    }
};