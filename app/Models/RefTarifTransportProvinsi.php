<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RefTarifTransportProvinsi extends Model
{
    protected $table = 'ref_tarif_transport_provinsi';
    public $timestamps = false;
    protected $fillable = ['id_provinsi', 'besaran'];

    public function provinsi() { return $this->belongsTo(RefProvinsi::class, 'id_provinsi'); }
}