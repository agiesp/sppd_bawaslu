<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RefTarifTransportDarat extends Model
{
    protected $table = 'ref_tarif_transport_darat';
    public $timestamps = false;
    protected $fillable = ['ibukota_provinsi', 'kabupaten_kota_tujuan', 'besaran'];
}