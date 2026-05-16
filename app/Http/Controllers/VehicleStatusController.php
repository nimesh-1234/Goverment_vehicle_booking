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
        $now = Carbon::now('Asia/Colombo')->format('Y-m-d H:i:s');

        $onTrip = Booking::whereIn('status', ['approved', 'Approved', 'on_trip', 'On Trip'])
            ->where('start_time', '<=', $now)
            ->where('end_time', '>=', $now)
            ->exists();

        $status = $onTrip ? 'On Trip' : 'Available';

        return response()->json([
            'status' => $status
        ]);
    }
}
