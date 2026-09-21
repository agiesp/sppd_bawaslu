<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Sppd extends Model
{
    protected $table = 'tb_sppd';

    protected $fillable = [
        'nomor_sppd', 'tahun', 'atas_nama', 'nip', 'pangkat_golongan', 'jabatan',
        'tanggal_mulai', 'tanggal_selesai', 'lama_hari',
        'asal_daerah', 'tujuan_daerah', 'provinsi_tujuan', 'keperluan', 'jenis_sppd',
        'status', 'total_biaya',
        'transport_udara', 'transport_darat_pp', 'taksi_bandara', 'transport_kendaraan_dinas_pp',
        'golongan', 'kota_asal_pesawat', 'kota_tujuan_pesawat',
        'file_surat_tugas', 'file_sppd',
        'created_by', 'approved_by', 'paid_by',
    ];

    protected $appends = ['file_surat_tugas_url', 'file_sppd_url'];

    protected function fileSuratTugasUrl(): Attribute
    {
        return Attribute::make(
            get: fn () => $this->file_surat_tugas
                ? '/storage/'.ltrim($this->file_surat_tugas, '/')
                : null,
        );
    }

    protected function fileSppdUrl(): Attribute
    {
        return Attribute::make(
            get: fn () => $this->file_sppd
                ? '/storage/'.ltrim($this->file_sppd, '/')
                : null,
        );
    }

    protected function casts(): array
    {
        return [
            'tahun' => 'integer',
            'tanggal_mulai' => 'date',
            'tanggal_selesai' => 'date',
            'lama_hari' => 'integer',
            'provinsi_tujuan' => 'integer',
            'total_biaya' => 'integer',
            'jenis_sppd' => 'string',
            'transport_udara' => 'boolean',
            'transport_darat_pp' => 'boolean',
            'taksi_bandara' => 'boolean',
            'transport_kendaraan_dinas_pp' => 'boolean',
        ];
    }

    protected function serializeDate(\DateTimeInterface $date): string
    {
        return $date->format('Y-m-d');
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

    public function pegawai(): BelongsTo
    {
        return $this->belongsTo(Pegawai::class, 'nip', 'nip');
    }
}
