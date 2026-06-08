<script setup lang="ts">
import { router } from '@inertiajs/vue3';
// import { approve as approveBookingRoute } from '@/routes/bookings.approve';
// import { return as returnBookingRoute } from '@/routes/bookings.return';

// Alternatively we could import from actions, but we can also import named routes.
// From earlier Wayfinder output, if using named routes:
// import { bookingsApprove } from '@/routes/bookings.approve';
// It's safer to just import the actions since we know the controller methods.
import { approve, markAsReturned } from '@/actions/App/Http/Controllers/BookingController';

const props = defineProps<{
    bookings: Array<{
        id: number;
        user: { name: string };
        destination: string;
        purpose: string;
        start_time: string;
        end_time: string;
        status: string;
    }>;
}>();

const handleApprove = (bookingId: number) => {
    if (confirm('Are you sure you want to approve this booking? This will auto-reject conflicting requests.')) {
        router.post(approve.url(bookingId), {}, {
            preserveScroll: true,
        });
    }
};

const handleReturn = (bookingId: number) => {
    if (confirm('Mark this vehicle as returned?')) {
        router.post(markAsReturned.url(bookingId), {}, {
            preserveScroll: true,
        });
    }
};

const getStatusColor = (status: string) => {
    switch(status) {
        case 'approved': return 'bg-green-100 text-green-800';
        case 'rejected': return 'bg-red-100 text-red-800';
        case 'completed': return 'bg-gray-100 text-gray-800';
        case 'on_trip': return 'bg-blue-100 text-blue-800';
        default: return 'bg-yellow-100 text-yellow-800';
    }
};
</script>

<template>
    <div class="bg-white rounded-lg shadow-sm overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h3 class="text-lg font-semibold">Manage Bookings</h3>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User / Branch</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Schedule</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <tr v-for="booking in bookings" :key="booking.id" class="hover:bg-gray-50">
                        <td class="px-6 py-4">
                            <div class="text-sm font-medium text-gray-900">{{ booking.user?.name || 'Unknown User' }}</div>
                            <div class="text-sm text-gray-500">{{ booking.purpose }}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            {{ booking.destination }}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <div>From: {{ new Date(booking.start_time).toLocaleString() }}</div>
                            <div>To: {{ new Date(booking.end_time).toLocaleString() }}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full" :class="getStatusColor(booking.status)">
                                {{ booking.status }}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                            <div class="flex justify-end gap-2">
                                <button v-if="booking.status === 'pending'"
                                        @click="handleApprove(booking.id)"
                                        class="text-indigo-600 hover:text-indigo-900 font-medium px-3 py-1 bg-indigo-50 hover:bg-indigo-100 rounded transition-colors">
                                    Approve
                                </button>
                                
                                <button v-if="booking.status === 'approved' || booking.status === 'on_trip'"
                                        @click="handleReturn(booking.id)"
                                        class="text-green-600 hover:text-green-900 font-medium px-3 py-1 bg-green-50 hover:bg-green-100 rounded transition-colors">
                                    Mark as Returned
                                </button>
                                
                                <span v-if="!['pending', 'approved', 'on_trip'].includes(booking.status)" class="text-gray-400 italic text-xs">
                                    No actions
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr v-if="bookings.length === 0">
                        <td colspan="5" class="px-6 py-8 text-center text-gray-500 italic">
                            No booking requests found.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>
