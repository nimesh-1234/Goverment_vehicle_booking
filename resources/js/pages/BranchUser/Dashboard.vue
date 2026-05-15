<script setup>
import { ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import AnimatedLayout from '@/Layouts/AnimatedLayout.vue';

const props = defineProps({
    // We would typically receive the current month's bookings here
    bookings: {
        type: Array,
        default: () => []
    }
});

const form = useForm({
    destination: '',
    purpose: '',
    estimated_distance: '',
    requires_allowance: false,
    remarks: '',
    start_time: '',
    end_time: '',
});

const submitBooking = () => {
    form.post(route('bookings.store'), {
        preserveScroll: true,
        onSuccess: () => {
            form.reset();
            alert('Booking request submitted successfully!');
        },
    });
};

// Simple Calendar Grid Logic (Mocking current month)
const daysInMonth = new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0).getDate();
const calendarDays = Array.from({ length: daysInMonth }, (_, i) => i + 1);

// Mock function to check if a day has a booking
const hasBooking = (day) => {
    // Just a visual placeholder: pretend days 10, 15, and 22 have bookings
    return [10, 15, 22].includes(day);
};
</script>

<template>
    <Head title="Branch Dashboard" />
    <AnimatedLayout>
        <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">Branch User Dashboard</h2>
            
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                
                <!-- Booking Request Form -->
                <div class="bg-white shadow overflow-hidden sm:rounded-lg p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">New Booking Request</h3>
                    
                    <form @submit.prevent="submitBooking" class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Destination</label>
                            <input v-model="form.destination" type="text" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            <div v-if="form.errors.destination" class="text-red-500 text-xs mt-1">{{ form.errors.destination }}</div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Purpose</label>
                            <input v-model="form.purpose" type="text" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            <div v-if="form.errors.purpose" class="text-red-500 text-xs mt-1">{{ form.errors.purpose }}</div>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Start Time</label>
                                <input v-model="form.start_time" type="datetime-local" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                <div v-if="form.errors.start_time" class="text-red-500 text-xs mt-1">{{ form.errors.start_time }}</div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">End Time</label>
                                <input v-model="form.end_time" type="datetime-local" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                                <div v-if="form.errors.end_time" class="text-red-500 text-xs mt-1">{{ form.errors.end_time }}</div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Estimated Distance (km)</label>
                            <input v-model="form.estimated_distance" type="text" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                        </div>

                        <div class="flex items-center">
                            <input v-model="form.requires_allowance" id="allowance" type="checkbox" class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="allowance" class="ml-2 block text-sm text-gray-900">Requires Driver Allowance</label>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Remarks</label>
                            <textarea v-model="form.remarks" rows="3" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"></textarea>
                        </div>

                        <div class="flex justify-end">
                            <button type="submit" :disabled="form.processing" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline disabled:opacity-50">
                                Submit Request
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Visual Calendar -->
                <div class="bg-white shadow overflow-hidden sm:rounded-lg p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Availability Calendar</h3>
                    <p class="text-sm text-gray-500 mb-4">Red indicates days with approved bookings.</p>
                    
                    <div class="grid grid-cols-7 gap-2 text-center">
                        <!-- Days of week -->
                        <div v-for="day in ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']" :key="day" class="font-semibold text-gray-600 text-sm py-2">
                            {{ day }}
                        </div>
                        
                        <!-- Calendar Days -->
                        <div v-for="day in calendarDays" :key="day" 
                             class="p-2 border rounded-md min-h-[60px] flex items-start justify-start text-sm"
                             :class="hasBooking(day) ? 'bg-red-100 border-red-200 text-red-800' : 'bg-green-50 border-green-100 text-green-800'">
                            <span class="font-bold">{{ day }}</span>
                            <div v-if="hasBooking(day)" class="mt-2 text-xs w-full text-center">Booked</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </AnimatedLayout>
</template>
