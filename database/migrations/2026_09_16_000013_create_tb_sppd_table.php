<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tb_sppd', function (Blueprint $table) {
            $table->id();
            $table->string('nomor_sppd', 50)->unique();
            $table->string('atas_nama', 150);
            $table->string('nip', 30)->nullable();
            $table->string('pangkat_golongan', 50)->nullable();
            $table->string('jabatan', 100)->nullable();
            $table->date('tanggal_mulai');
            $table->date('tanggal_selesai');
            $table->integer('lama_hari')->default(0);
            $table->string('asal_daerah', 100)->default('Sigli');
            $table->string('tujuan_daerah', 100);
            $table->integer('provinsi_tujuan');
            $table->text('keperluan')->nullable();
            $table->enum('status', ['draft', 'proses', 'selesai', 'batal'])->default('draft');
            $table->bigInteger('total_biaya')->default(0);
            $table->integer('created_by')->nullable();
            $table->integer('approved_by')->nullable();
            $table->integer('paid_by')->nullable();
            $table->timestamps();
            $table->foreign('provinsi_tujuan')->references('id_provinsi')->on('ref_provinsi');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tb_sppd');
    }
};