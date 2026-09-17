<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SppdRincian extends Model
{
    protected $table = 'tb_sppd_rincian';
    public $timestamps = false;
    protected $fillable = ['id_sppd', 'jenis_biaya', 'uraian', 'hari', 'satuan', 'jumlah', 'keterangan'];

    protected function casts(): array
    {
        return [
            'hari' => 'integer',
            'satuan' => 'integer',
            'jumlah' => 'integer',
        ];
    }

    public function sppd(): BelongsTo
    {
        return $this->belongsTo(Sppd::class, 'id_sppd');
    }
}