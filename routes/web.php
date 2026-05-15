<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\VehicleStatusController;
use App\Models\Branch;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Home', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
        'branches' => Branch::all(),
    ]);
});

// Vehicle Status (Public)
Route::get('/vehicle-status', VehicleStatusController::class)->name('vehicle.status');

use App\Models\Booking;

Route::get('/dashboard', function (Illuminate\Http\Request $request) {
    $user = $request->user();
    $bookings = [];

    if ($user->role === 'transport_admin') {
        $bookings = Booking::with('user')->orderBy('created_at', 'desc')->get();
    } elseif ($user->role === 'branch_user') {
        // branch user sees only their branch bookings or their own bookings
        $bookings = Booking::where('user_id', $user->id)->orderBy('created_at', 'desc')->get();
    }

    return Inertia::render('Dashboard', [
        'bookings' => $bookings,
        'userRole' => $user->role,
    ]);
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
});

require __DIR__.'/auth.php';
