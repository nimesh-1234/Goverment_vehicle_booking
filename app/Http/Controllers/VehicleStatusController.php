<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class VehicleStatusController extends Controller
{
    /**
     * Get the current status of the vehicle.
     */
    public function __invoke(Request $request): JsonResponse
    {
        $nowUtc = now()->timezone('UTC');

        $onTrip = Booking::whereIn('status', ['approved', 'Approved', 'on_trip', 'On Trip'])
            ->where('start_time', '<=', $nowUtc)
            ->where('end_time', '>=', $nowUtc)
            ->exists();

        $status = $onTrip ? 'On Trip' : 'Available';

        return response()->json([
            'status' => $status
        ]);
    }
}
