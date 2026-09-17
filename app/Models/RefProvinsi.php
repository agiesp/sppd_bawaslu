<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RefProvinsi extends Model
{
    protected $table = 'ref_provinsi';
    protected $primaryKey = 'id_provinsi';
    public $timestamps = false;
    protected $fillable = ['id_provinsi', 'nama_provinsi', 'ibukota'];

    public function tarifHarian() { return $this->hasOne(RefTarifHarian::class, 'id_provinsi'); }
    public function tarifPenginapan() { return $this->hasOne(RefTarifPenginapan::class, 'id_provinsi'); }
    public function tarifTransportProvinsi() { return $this->hasOne(RefTarifTransportProvinsi::class, 'id_provinsi'); }
}