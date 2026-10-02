<?php

use App\Http\Controllers\WebAuthController;
use App\Http\Controllers\WebDashboardController;
use Illuminate\Support\Facades\Route;

Route::get('/', fn () => redirect()->route('register'));

Route::get('/register', [WebAuthController::class, 'showRegister'])->name('register');
Route::post('/register', [WebAuthController::class, 'register'])->name('register.store');

Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [WebDashboardController::class, 'index'])->name('dashboard');
});
