<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;

class Pegawai extends Model
{
    protected $table = 'ref_pegawai';
    public $timestamps = false;
    protected $fillable = ['nama_pegawai', 'nip', 'pangkat_golongan', 'jabatan', 'tipe', 'avatar'];

    protected $appends = ['avatar_url'];

    protected function avatarUrl(): Attribute
    {
        return Attribute::make(
            get: fn () => $this->avatar
                ? '/storage/' . ltrim($this->avatar, '/')
                : null,
        );
    }
}