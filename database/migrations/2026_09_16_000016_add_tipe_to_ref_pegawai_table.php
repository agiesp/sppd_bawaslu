<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('ref_pegawai', function (Blueprint $table) {
            $table->string('tipe', 20)->default('pegawai')->after('jabatan');
        });
    }

    public function down(): void
    {
        Schema::table('ref_pegawai', function (Blueprint $table) {
            $table->dropColumn('tipe');
        });
    }
};