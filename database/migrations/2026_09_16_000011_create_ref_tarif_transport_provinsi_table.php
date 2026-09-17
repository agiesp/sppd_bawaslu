<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ref_tarif_transport_provinsi', function (Blueprint $table) {
            $table->id();
            $table->integer('id_provinsi');
            $table->integer('besaran')->default(0);
            $table->foreign('id_provinsi')->references('id_provinsi')->on('ref_provinsi');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ref_tarif_transport_provinsi');
    }
};