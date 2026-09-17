<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Sppd extends Model
{
    protected $table = 'tb_sppd';
    protected $fillable = [
        'nomor_sppd', 'atas_nama', 'nip', 'pangkat_golongan', 'jabatan',
        'tanggal_mulai', 'tanggal_selesai', 'lama_hari',
        'asal_daerah', 'tujuan_daerah', 'provinsi_tujuan', 'keperluan',
        'status', 'total_biaya',
        'created_by', 'approved_by', 'paid_by',
    ];

    protected function casts(): array
    {
        return [
            'tanggal_mulai' => 'date',
            'tanggal_selesai' => 'date',
            'lama_hari' => 'integer',
            'provinsi_tujuan' => 'integer',
            'total_biaya' => 'integer',
        ];
    }

    public function rincian(): HasMany
    {
        return $this->hasMany(SppdRincian::class, 'id_sppd');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }

    public function payer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'paid_by');
    }

    public function provinsi(): BelongsTo
    {
        return $this->belongsTo(RefProvinsi::class, 'provinsi_tujuan');
    }
}