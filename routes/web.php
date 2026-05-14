<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\VehicleStatusController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Branch Users
    Route::middleware('role:branch_user')->group(function () {
        Route::post('/bookings', [BookingController::class, 'store'])->name('bookings.store');
    });

    // Top Management & Transport Admin
    Route::middleware('role:top_management,transport_admin')->group(function () {
        Route::post('/bookings/{booking}/approve', [BookingController::class, 'approve'])->name('bookings.approve');
    });

    // Transport Admin
    Route::middleware('role:transport_admin')->group(function () {
        Route::post('/bookings/{booking}/return', [BookingController::class, 'markAsReturned'])->name('bookings.return');
    });

    // Vehicle Status
    Route::get('/vehicle-status', VehicleStatusController::class)->name('vehicle.status');
});

require __DIR__.'/auth.php';
