<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;

class BookingController extends Controller
{
    /**
     * Store a newly created booking request (Branch Users).
     */
    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'destination' => 'required|string|max:255',
            'purpose' => 'required|string|max:255',
            'estimated_distance' => 'nullable|string',
            'requires_allowance' => 'boolean',
            'remarks' => 'nullable|string',
            'start_time' => 'required|date|after:now',
            'end_time' => 'required|date|after:start_time',
        ]);

        $booking = Booking::create([
            'user_id' => $request->user()->id,
            // Assuming branch_id comes from the user's branch
            'branch_id' => $request->user()->branch_id,
            'destination' => $validated['destination'],
            'purpose' => $validated['purpose'],
            'estimated_distance' => $validated['estimated_distance'] ?? null,
            'requires_allowance' => $validated['requires_allowance'] ?? false,
            'remarks' => $validated['remarks'] ?? null,
            'start_time' => $validated['start_time'],
            'end_time' => $validated['end_time'],
            'status' => 'pending',
        ]);

        return redirect()->back()->with('success', 'Booking requested successfully.');
    }

    /**
     * Approve a booking with Auto-Reject logic (Top Management / Transport Admin).
     */
    public function approve(Booking $booking): RedirectResponse
    {
        $booking->update(['status' => 'approved']);

        // Auto-Reject overlapping pending bookings
        Booking::where('id', '!=', $booking->id)
            ->where('status', 'pending')
            ->where(function ($query) use ($booking) {
                // An overlap occurs if the pending booking starts before the approved booking ends,
                // and ends after the approved booking starts.
                $query->where('start_time', '<', $booking->end_time)
                      ->where('end_time', '>', $booking->start_time);
            })
            ->update(['status' => 'rejected']);

        return redirect()->back()->with('success', 'Booking approved and overlapping requests rejected.');
    }

    /**
     * Mark a booking as returned / completed (Transport Admin).
     */
    public function markAsReturned(Booking $booking): RedirectResponse
    {
        $booking->update(['status' => 'completed']);

        return redirect()->back()->with('success', 'Vehicle marked as returned.');
    }
}
