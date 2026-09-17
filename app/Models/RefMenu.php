<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class RefMenu extends Model
{
    use HasFactory;

    protected $table = 'ref_menu';

    protected $fillable = ['parent_id', 'name', 'icon', 'url', 'order', 'is_active'];

    protected function casts(): array
    {
        return [
            'is_active' => 'boolean',
            'order' => 'integer',
        ];
    }

    public function parent(): BelongsTo
    {
        return $this->belongsTo(RefMenu::class, 'parent_id');
    }

    public function children(): HasMany
    {
        return $this->hasMany(RefMenu::class, 'parent_id')->orderBy('order');
    }
}