<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RefTarifHarian extends Model
{
    protected $table = 'ref_tarif_harian';
    public $timestamps = false;
    protected $fillable = ['id_provinsi', 'luar_kota', 'dalam_kota_lebih_8_jam', 'diklat'];

    public function provinsi() { return $this->belongsTo(RefProvinsi::class, 'id_provinsi'); }
}