<script setup>
import { ref } from 'vue';
import { Head, router } from '@inertiajs/vue3';
import AnimatedLayout from '@/layouts/AnimatedLayout.vue';

const props = defineProps({
    // We would receive real bookings data from backend here
    bookings: {
        type: Array,
        default: () => [
            // Mock data for display purposes
            { id: 1, destination: 'Ministry of Health', purpose: 'Official Meeting', status: 'pending', start_time: '2026-05-15 09:00', end_time: '2026-05-15 12:00' },
            { id: 2, destination: 'Parliament', purpose: 'Session', status: 'approved', start_time: '2026-05-16 10:00', end_time: '2026-05-16 14:00' },
            { id: 3, destination: 'Airport', purpose: 'Pickup Delegate', status: 'on_trip', start_time: '2026-05-14 08:00', end_time: '2026-05-14 16:00' },
        ]
    }
});

const approveBooking = (id) => {
    if (confirm('Are you sure you want to approve this booking? Overlapping requests will be rejected.')) {
        router.post(route('bookings.approve', id), {}, {
            preserveScroll: true,
            onSuccess: () => alert('Booking approved.')
        });
    }
};

const markAsReturned = (id) => {
    if (confirm('Mark this vehicle as returned?')) {
        router.post(route('bookings.return', id), {}, {
            preserveScroll: true,
            onSuccess: () => alert('Vehicle marked as returned.')
        });
    }
};
</script>

<template>
    <Head title="Transport Admin Dashboard" />
    <AnimatedLayout>
        <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">Transport Admin Dashboard</h2>
            
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6 flex justify-between items-center">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Manage Bookings</h3>
                </div>
                
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination / Purpose</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Timeframe</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <tr v-for="booking in bookings" :key="booking.id">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">{{ booking.destination }}</div>
                                    <div class="text-sm text-gray-500">{{ booking.purpose }}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">Start: {{ booking.start_time }}</div>
                                    <div class="text-sm text-gray-500">End: {{ booking.end_time }}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full uppercase"
                                          :class="{
                                              'bg-yellow-100 text-yellow-800': booking.status === 'pending',
                                              'bg-blue-100 text-blue-800': booking.status === 'approved',
                                              'bg-purple-100 text-purple-800': booking.status === 'on_trip',
                                              'bg-green-100 text-green-800': booking.status === 'completed',
                                              'bg-red-100 text-red-800': booking.status === 'rejected'
                                          }">
                                        {{ booking.status.replace('_', ' ') }}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-2">
                                    
                                    <!-- Approve Button (Only for pending) -->
                                    <button v-if="booking.status === 'pending'" 
                                            @click="approveBooking(booking.id)"
                                            class="text-green-600 hover:text-green-900 bg-green-50 px-3 py-1 rounded">
                                        Approve
                                    </button>
                                    
                                    <!-- Mark as Returned Button (For approved/on_trip) -->
                                    <button v-if="booking.status === 'approved' || booking.status === 'on_trip'" 
                                            @click="markAsReturned(booking.id)"
                                            class="text-blue-600 hover:text-blue-900 bg-blue-50 px-3 py-1 rounded">
                                        Mark Returned
                                    </button>

                                </td>
                            </tr>
                            <tr v-if="bookings.length === 0">
                                <td colspan="4" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                                    No bookings found.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AnimatedLayout>
</template>
