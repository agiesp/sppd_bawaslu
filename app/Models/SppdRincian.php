<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SppdRincian extends Model
{
    protected $table = 'tb_sppd_rincian';
    public $timestamps = false;
    protected $fillable = ['id_sppd', 'tahun', 'jenis_biaya', 'uraian', 'hari', 'satuan', 'jumlah', 'keterangan', 'bukti'];

    protected $appends = ['bukti_url'];

    protected function buktiUrl(): Attribute
    {
        return Attribute::make(
            get: fn () => $this->bukti
                ? '/storage/' . ltrim($this->bukti, '/')
                : null,
        );
    }

    protected function casts(): array
    {
        return [
            'tahun' => 'integer',
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