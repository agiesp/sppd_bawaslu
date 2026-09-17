<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RefTarifPesawat extends Model
{
    protected $table = 'ref_tarif_pesawat';
    public $timestamps = false;
    protected $fillable = ['kota_asal', 'kota_tujuan', 'tarif_bisnis', 'tarif_ekonomi'];
}