<script setup lang="ts">
import { useForm } from '@inertiajs/vue3';
import { store as storeBooking } from '@/actions/App/Http/Controllers/BookingController';
import { ref, computed } from 'vue';

const props = defineProps<{
    bookings: Array<{
        id: number;
        start_time: string;
        end_time: string;
        status: string;
        purpose: string;
        destination: string;
    }>;
}>();

const form = useForm({
    start_time: '',
    end_time: '',
    purpose: '',
    destination: '',
});

const submitBooking = () => {
    form.submit(storeBooking(), {
        onSuccess: () => {
            form.reset();
        }
    });
};

// Generate next 7 days for the visual calendar
const calendarDays = computed(() => {
    const days = [];
    const today = new Date();
    for (let i = 0; i < 7; i++) {
        const date = new Date(today);
        date.setDate(today.getDate() + i);
        const dateStr = date.toISOString().split('T')[0];
        
        // Find if user has a booking on this day
        const dayBookings = props.bookings.filter(b => {
            const bStart = b.start_time.split(' ')[0];
            const bEnd = b.end_time.split(' ')[0];
            return dateStr >= bStart && dateStr <= bEnd;
        });

        days.push({
            date: date,
            dateStr,
            dayName: date.toLocaleDateString('en-US', { weekday: 'short' }),
            dayNumber: date.getDate(),
            bookings: dayBookings,
        });
    }
    return days;
});

const getStatusColor = (status: string) => {
    switch(status) {
        case 'approved': return 'bg-green-100 text-green-800 border-green-200';
        case 'rejected': return 'bg-red-100 text-red-800 border-red-200';
        case 'completed': return 'bg-gray-100 text-gray-800 border-gray-200';
        case 'on_trip': return 'bg-blue-100 text-blue-800 border-blue-200';
        default: return 'bg-yellow-100 text-yellow-800 border-yellow-200';
    }
};
</script>

<template>
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Calendar Section -->
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white p-6 rounded-lg shadow-sm">
                <h3 class="text-lg font-semibold mb-4">Your Upcoming Schedule (Next 7 Days)</h3>
                <div class="grid grid-cols-7 gap-2">
                    <div v-for="day in calendarDays" :key="day.dateStr" class="border rounded-lg p-2 min-h-24 flex flex-col bg-gray-50">
                        <div class="text-xs font-bold text-gray-500 uppercase text-center border-b pb-1 mb-1">
                            {{ day.dayName }} <br/> {{ day.dayNumber }}
                        </div>
                        <div class="flex-1 overflow-y-auto space-y-1">
                            <div v-for="booking in day.bookings" :key="booking.id"
                                 class="text-[10px] p-1 rounded border leading-tight truncate"
                                 :class="getStatusColor(booking.status)"
                                 :title="booking.purpose">
                                {{ booking.status }}
                            </div>
                            <div v-if="day.bookings.length === 0" class="text-xs text-gray-400 text-center mt-2 italic">
                                Free
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- List of all user's bookings -->
            <div class="bg-white p-6 rounded-lg shadow-sm">
                <h3 class="text-lg font-semibold mb-4">My Bookings</h3>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Destination</th>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Start</th>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">End</th>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 bg-white text-sm">
                            <tr v-for="booking in bookings" :key="booking.id">
                                <td class="px-4 py-3">{{ booking.destination }}</td>
                                <td class="px-4 py-3 whitespace-nowrap">{{ booking.start_time }}</td>
                                <td class="px-4 py-3 whitespace-nowrap">{{ booking.end_time }}</td>
                                <td class="px-4 py-3 whitespace-nowrap">
                                    <span class="px-2 py-1 text-xs font-semibold rounded-full" :class="getStatusColor(booking.status)">
                                        {{ booking.status }}
                                    </span>
                                </td>
                            </tr>
                            <tr v-if="bookings.length === 0">
                                <td colspan="4" class="px-4 py-6 text-center text-gray-500 italic">No bookings found.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Booking Form Section -->
        <div class="lg:col-span-1">
            <div class="bg-white p-6 rounded-lg shadow-sm sticky top-6">
                <h3 class="text-lg font-semibold mb-4">Request Vehicle</h3>
                <form @submit.prevent="submitBooking" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Destination</label>
                        <input v-model="form.destination" type="text" class="w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500" required />
                        <div v-if="form.errors.destination" class="text-red-500 text-xs mt-1">{{ form.errors.destination }}</div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Purpose</label>
                        <textarea v-model="form.purpose" rows="3" class="w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500" required></textarea>
                        <div v-if="form.errors.purpose" class="text-red-500 text-xs mt-1">{{ form.errors.purpose }}</div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Start Time</label>
                        <input v-model="form.start_time" type="datetime-local" class="w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500" required />
                        <div v-if="form.errors.start_time" class="text-red-500 text-xs mt-1">{{ form.errors.start_time }}</div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">End Time</label>
                        <input v-model="form.end_time" type="datetime-local" class="w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500" required />
                        <div v-if="form.errors.end_time" class="text-red-500 text-xs mt-1">{{ form.errors.end_time }}</div>
                    </div>

                    <button type="submit" :disabled="form.processing" class="w-full bg-blue-600 text-white font-bold py-2 px-4 rounded hover:bg-blue-700 disabled:opacity-50 transition-colors">
                        Submit Request
                    </button>
                    
                    <div v-if="form.recentlySuccessful" class="text-green-600 text-sm mt-2 font-medium">
                        Request submitted successfully!
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
