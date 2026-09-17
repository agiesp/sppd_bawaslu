<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ref_pegawai', function (Blueprint $table) {
            $table->id();
            $table->string('nama_pegawai', 150);
            $table->string('nip', 30)->nullable();
            $table->string('pangkat_golongan', 50)->nullable();
            $table->string('jabatan', 100)->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ref_pegawai');
    }
};