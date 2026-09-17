<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\MenuController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\PegawaiController;
use App\Http\Controllers\ReferensiController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\SettingsController;
use App\Http\Controllers\SppdController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

// Health check
Route::get('/up', function () {
    });

// Auth
Route::get('/signin', [AuthController::class, 'showLogin'])->name('login');
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth');

// Dashboard
Route::get('/dashboard', [DashboardController::class, 'index'])->middleware('auth', 'permission:/dashboard:view');

// SPPD
Route::get('/sppd', [SppdController::class, 'index'])->middleware('auth', 'permission:/sppd:view');
Route::get('/sppd/buat', [SppdController::class, 'create'])->middleware('auth', 'permission:/sppd:create');
Route::post('/sppd', [SppdController::class, 'store'])->middleware('auth', 'permission:/sppd:create');
Route::get('/sppd/{sppd}/edit', [SppdController::class, 'edit'])->middleware('auth', 'permission:/sppd:edit');
Route::get('/sppd/{sppd}', [SppdController::class, 'show'])->middleware('auth', 'permission:/sppd:view');
Route::put('/sppd/{sppd}', [SppdController::class, 'update'])->middleware('auth', 'permission:/sppd:edit');
Route::delete('/sppd/{sppd}', [SppdController::class, 'destroy'])->middleware('auth', 'permission:/sppd:delete');
Route::post('/sppd/{sppd}/rincian', [SppdController::class, 'storeRincian'])->middleware('auth', 'permission:/sppd:edit');
Route::post('/sppd/bukti', [SppdController::class, 'uploadBukti'])->middleware('auth');
Route::post('/sppd/{sppd}/dokumen', [SppdController::class, 'uploadDokumen'])->middleware('auth', 'permission:/sppd:edit');
Route::delete('/sppd/{sppd}/dokumen', [SppdController::class, 'hapusDokumen'])->middleware('auth', 'permission:/sppd:edit');
Route::get('/sppd/{sppd}/cetak', [SppdController::class, 'cetak'])->middleware('auth', 'permission:/sppd:view');

// Referensi
Route::get('/admin/referensi', [ReferensiController::class, 'index'])->middleware('auth', 'permission:/admin/referensi:view');
Route::put('/admin/referensi/tarif-harian/{tarif}', [ReferensiController::class, 'updateTarifHarian'])->middleware('auth', 'permission:/admin/referensi:edit');
Route::put('/admin/referensi/tarif-penginapan/{tarif}', [ReferensiController::class, 'updateTarifPenginapan'])->middleware('auth', 'permission:/admin/referensi:edit');
Route::put('/admin/referensi/tarif-pesawat/{tarif}', [ReferensiController::class, 'updateTarifPesawat'])->middleware('auth', 'permission:/admin/referensi:edit');
Route::put('/admin/referensi/tarif-transport-darat/{tarif}', [ReferensiController::class, 'updateTarifTransportDarat'])->middleware('auth', 'permission:/admin/referensi:edit');
Route::put('/admin/referensi/tarif-transport-provinsi/{tarif}', [ReferensiController::class, 'updateTarifTransportProvinsi'])->middleware('auth', 'permission:/admin/referensi:edit');

// Pegawai
Route::get('/admin/master/pegawai', [PegawaiController::class, 'index'])->middleware('auth', 'permission:/admin/master/pegawai:view');
Route::post('/admin/master/pegawai', [PegawaiController::class, 'store'])->middleware('auth', 'permission:/admin/master/pegawai:create');
Route::put('/admin/master/pegawai/{id}', [PegawaiController::class, 'update'])->middleware('auth', 'permission:/admin/master/pegawai:edit');
Route::delete('/admin/master/pegawai/{id}', [PegawaiController::class, 'destroy'])->middleware('auth', 'permission:/admin/master/pegawai:delete');

// User Management
Route::get('/users', [UserController::class, 'index'])->middleware('auth', 'permission:/users:view');
Route::post('/users', [UserController::class, 'store'])->middleware('auth', 'permission:/users:create');
Route::put('/users/{user}', [UserController::class, 'update'])->middleware('auth', 'permission:/users:edit');
Route::delete('/users/{user}', [UserController::class, 'destroy'])->middleware('auth', 'permission:/users:delete');

// Role Management
Route::get('/roles', [RoleController::class, 'index'])->middleware('auth', 'permission:/roles:view');
Route::post('/roles', [RoleController::class, 'store'])->middleware('auth', 'permission:/roles:create');
Route::put('/roles/{role}', [RoleController::class, 'update'])->middleware('auth', 'permission:/roles:edit');
Route::delete('/roles/{role}', [RoleController::class, 'destroy'])->middleware('auth', 'permission:/roles:delete');
Route::post('/roles/{role}/permissions', [RoleController::class, 'savePermissions'])->middleware('auth', 'permission:/roles:edit');

// Menu Management
Route::get('/menus', [MenuController::class, 'index'])->middleware('auth', 'permission:/menus:view');
Route::post('/menus', [MenuController::class, 'store'])->middleware('auth', 'permission:/menus:create');
Route::put('/menus/{menu}', [MenuController::class, 'update'])->middleware('auth', 'permission:/menus:edit');
Route::delete('/menus/{menu}', [MenuController::class, 'destroy'])->middleware('auth', 'permission:/menus:delete');

// System Settings
Route::get('/admin/system', [SettingsController::class, 'index'])->middleware('auth', 'permission:/admin/system:view');
Route::put('/admin/system', [SettingsController::class, 'update'])->middleware('auth', 'permission:/admin/system:edit');

// SPA Catch-all
Route::get('/{any}', [PageController::class, 'show'])->where('any', '.*')->middleware('auth');