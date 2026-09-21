<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->enum('jenis_sppd', ['dalam', 'luar'])
                ->default('luar')
                ->after('asal_daerah');
        });
    }

    public function down(): void
    {
        Schema::table('tb_sppd', function (Blueprint $table) {
            $table->dropColumn('jenis_sppd');
        });
    }
};