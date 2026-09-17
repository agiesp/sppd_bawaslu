<?php

use App\Http\Controllers\DashboardController;
use App\Http\Controllers\SppdController;
use Illuminate\Support\Facades\Route;

Route::middleware(['web', 'auth'])->group(function () {
    Route::get('dashboard/metrics', [DashboardController::class, 'metrics']);
    Route::post('sppd/calculate', [SppdController::class, 'calculate']);
});