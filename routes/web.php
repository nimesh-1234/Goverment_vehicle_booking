<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\SuperAdminController;
use App\Http\Controllers\VehicleStatusController;
use App\Models\Branch;
use App\Models\Booking;
use App\Models\User;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (auth()->check()) {
        return redirect()->route('dashboard');
    }

    return Inertia::render('Home', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
        'branches' => Branch::all(),
    ]);
})->name('home');

// Vehicle Status (Public)
Route::get('/vehicle-status', VehicleStatusController::class)->name('vehicle.status');

Route::get('/dashboard', function (Illuminate\Http\Request $request) {
    $user = $request->user();

    switch ($user->role) {
        case 'super_admin':
            return Inertia::render('SuperAdminDashboard', [
                'branches' => Branch::all(),
                'users' => User::all(),
                'allBookings' => Booking::with('user', 'branch')->orderBy('created_at', 'desc')->get(),
            ]);

        case 'branch_user':
            return Inertia::render('BranchUserDashboard', [
                'branchName' => \Illuminate\Support\Facades\Auth::user()->branch?->name ?? 'Unknown Branch',
                'approvedBookings' => Booking::whereIn('status', ['Approved', 'approved'])->get(),
                'history' => Booking::where('branch_id', $user->branch_id)->orderBy('created_at', 'desc')->get(),
            ]);

        case 'transport_admin':
            return Inertia::render('TransportAdminDashboard', [
                'pendingRequests' => Booking::with('user')->whereIn('status', ['Pending', 'pending'])->orderBy('created_at', 'asc')->get(),
                'activeTrip' => Booking::with('user')
                    ->whereIn('status', ['Approved', 'approved', 'On Trip', 'on_trip'])
                    ->where('start_time', '<=', \Carbon\Carbon::now('Asia/Colombo')->toDateTimeString())
                    ->where('end_time', '>=', \Carbon\Carbon::now('Asia/Colombo')->toDateTimeString())
                    ->first(),
                'allBookings' => Booking::with('user', 'branch')->orderBy('created_at', 'desc')->get(),
            ]);

        case 'top_management':
            return Inertia::render('TopManagementDashboard', [
                'approvedBookings' => Booking::with('user')->whereIn('status', ['Approved', 'approved'])->get(),
                'stats' => [
                    'todayBookings' => Booking::whereDate('created_at', today())->count(),
                    'weeklyApproved' => Booking::whereIn('status', ['Approved', 'approved'])->whereBetween('updated_at', [now()->startOfWeek(), now()->endOfWeek()])->count(),
                    'weeklyRejected' => Booking::whereIn('status', ['Rejected', 'rejected'])->whereBetween('updated_at', [now()->startOfWeek(), now()->endOfWeek()])->count(),
                ]
            ]);

        default:
            return Inertia::render('Dashboard', [
                'userRole' => $user->role,
            ]);
    }
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
        Route::post('/bookings/{booking}/reject', [BookingController::class, 'reject'])->name('bookings.reject');
    });

    // Transport Admin
    Route::middleware('role:transport_admin')->group(function () {
        Route::post('/bookings/{booking}/mark-returned', [BookingController::class, 'markAsReturned'])->name('bookings.mark-returned');
        Route::put('/bookings/{booking}', [BookingController::class, 'update'])->name('transport-admin.bookings.update');
        Route::delete('/bookings/{booking}', [BookingController::class, 'destroy'])->name('transport-admin.bookings.destroy');
    });

    // Super Admin
    Route::middleware('role:super_admin')->group(function () {
        // Branches
        Route::post('/super-admin/branches', [SuperAdminController::class, 'storeBranch'])->name('super-admin.branches.store');
        Route::put('/super-admin/branches/{branch}', [SuperAdminController::class, 'updateBranch'])->name('super-admin.branches.update');
        Route::delete('/super-admin/branches/{branch}', [SuperAdminController::class, 'destroyBranch'])->name('super-admin.branches.destroy');

        // Users
        Route::post('/super-admin/users', [SuperAdminController::class, 'storeUser'])->name('super-admin.users.store');
        Route::put('/super-admin/users/{user}', [SuperAdminController::class, 'updateUser'])->name('super-admin.users.update');
        Route::delete('/super-admin/users/{user}', [SuperAdminController::class, 'destroyUser'])->name('super-admin.users.destroy');
        
        // Bookings
        Route::put('/super-admin/bookings/{booking}', [BookingController::class, 'update'])->name('super-admin.bookings.update');
        Route::delete('/super-admin/bookings/{booking}', [BookingController::class, 'destroy'])->name('super-admin.bookings.destroy');
    });
});

require __DIR__.'/auth.php';
