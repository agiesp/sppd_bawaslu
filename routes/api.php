<?php

use App\Http\Controllers\DashboardController;
use App\Http\Controllers\SppdController;
use Illuminate\Support\Facades\Route;

Route::middleware(['web', 'auth'])->group(function () {
    Route::get('dashboard/metrics', [DashboardController::class, 'metrics']);
    Route::get('dashboard/schedule', [DashboardController::class, 'schedule']);
    Route::get('dashboard/financing', [DashboardController::class, 'financing']);
    Route::get('dashboard/notifications', [DashboardController::class, 'notifications']);
    Route::post('sppd/calculate', [SppdController::class, 'calculate']);
});