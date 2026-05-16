<?php

namespace App\Http\Middleware;

use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        return [
            ...parent::share($request),
            'auth' => [
                'user' => $request->user(),
            ],
            'currentStatus' => function () {
                $now = \Carbon\Carbon::now('Asia/Colombo')->toDateTimeString();
                $isOnTrip = \App\Models\Booking::whereIn('status', ['approved', 'Approved', 'on_trip', 'On Trip'])
                    ->where('start_time', '<=', $now)
                    ->where('end_time', '>=', $now)
                    ->exists();
                return $isOnTrip ? 'On Trip' : 'Available';
            },
        ];
    }
}
