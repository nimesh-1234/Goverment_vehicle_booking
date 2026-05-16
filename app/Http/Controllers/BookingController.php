<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use Carbon\Carbon;
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
            'start_time' => Carbon::parse($validated['start_time'], 'Asia/Colombo')->format('Y-m-d H:i:s'),
            'end_time' => Carbon::parse($validated['end_time'], 'Asia/Colombo')->format('Y-m-d H:i:s'),
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
     * Reject a booking.
     */
    public function reject(Booking $booking): RedirectResponse
    {
        $booking->update(['status' => 'rejected']);

        return redirect()->back()->with('success', 'Booking rejected.');
    }

    /**
     * Mark a booking as returned / completed (Transport Admin).
     */
    public function markAsReturned(Booking $booking): RedirectResponse
    {
        $booking->update(['status' => 'completed']);

        return redirect()->back()->with('success', 'Vehicle marked as returned.');
    }

    /**
     * Update an existing booking (Admin/Super Admin).
     */
    public function update(Request $request, Booking $booking): RedirectResponse
    {
        $validated = $request->validate([
            'destination' => 'required|string|max:255',
            'purpose' => 'required|string|max:255',
            'start_time' => 'required|date',
            'end_time' => 'required|date|after:start_time',
            'status' => 'required|string|in:pending,approved,rejected,completed,On Trip',
        ]);

        $booking->update([
            'destination' => $validated['destination'],
            'purpose' => $validated['purpose'],
            'start_time' => Carbon::parse($validated['start_time'], 'Asia/Colombo')->format('Y-m-d H:i:s'),
            'end_time' => Carbon::parse($validated['end_time'], 'Asia/Colombo')->format('Y-m-d H:i:s'),
            'status' => strtolower($validated['status']),
        ]);

        return redirect()->back()->with('success', 'Booking updated successfully.');
    }

    /**
     * Delete a booking (Admin/Super Admin).
     */
    public function destroy(Booking $booking): RedirectResponse
    {
        $booking->delete();

        return redirect()->back()->with('success', 'Booking deleted successfully.');
    }
}
