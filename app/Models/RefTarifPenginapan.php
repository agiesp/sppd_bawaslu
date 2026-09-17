<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RefTarifPenginapan extends Model
{
    protected $table = 'ref_tarif_penginapan';
    public $timestamps = false;
    protected $fillable = ['id_provinsi', 'pejabat_negara_eselon_1', 'pejabat_lainnya_eselon_2', 'eselon_3_gol_4', 'eselon_4_gol_3_2_1'];

    public function provinsi() { return $this->belongsTo(RefProvinsi::class, 'id_provinsi'); }
}