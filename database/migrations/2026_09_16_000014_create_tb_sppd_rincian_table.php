<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tb_sppd_rincian', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_sppd')->constrained('tb_sppd')->onDelete('cascade');
            $table->enum('jenis_biaya', [
                'uang_harian', 'uang_saku', 'penginapan',
                'transport_udara_pp', 'transport_udara_pergi', 'transport_udara_pulang',
                'transport_darat', 'transport_dinas_pp', 'taksi_bandara', 'transport_lainnya',
            ]);
            $table->string('uraian', 255);
            $table->integer('hari')->default(1);
            $table->integer('satuan')->default(0);
            $table->integer('jumlah')->default(0);
            $table->string('keterangan', 255)->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tb_sppd_rincian');
    }
};