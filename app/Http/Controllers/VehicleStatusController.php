<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class VehicleStatusController extends Controller
{
    /**
     * Get the current status of the vehicle.
     */
    public function __invoke(Request $request): JsonResponse
    {
        $now = now();

        $onTrip = Booking::whereIn('status', ['approved', 'on_trip'])
            ->where('start_time', '<=', $now)
            ->where('end_time', '>=', $now)
            ->exists();

        $status = $onTrip ? 'On Trip' : 'Available';

        return response()->json([
            'status' => $status
        ]);
    }
}
