<template>
  <MainLayout>
    <div class="space-y-6">
      <h2 class="text-2xl font-semibold text-gray-800">Branch User Dashboard</h2>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Calendar Section -->
        <div class="md:col-span-2 bg-white p-6 rounded-lg shadow-sm">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Approved Bookings Calendar</h3>
          <FullCalendar :options="calendarOptions" />
        </div>

        <!-- Booking Form Section -->
        <div class="bg-white p-6 rounded-lg shadow-sm h-fit">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Request a Vehicle</h3>
          <form @submit.prevent="submitBooking" class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-gray-700">Start Time</label>
              <input type="datetime-local" v-model="form.start_time" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
              <div v-if="form.errors.start_time" class="text-red-600 text-sm mt-1">{{ form.errors.start_time }}</div>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700">End Time</label>
              <input type="datetime-local" v-model="form.end_time" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
              <div v-if="form.errors.end_time" class="text-red-600 text-sm mt-1">{{ form.errors.end_time }}</div>
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700">Destination</label>
              <input type="text" v-model="form.destination" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" placeholder="Colombo" required />
              <div v-if="form.errors.destination" class="text-red-600 text-sm mt-1">{{ form.errors.destination }}</div>
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700">Purpose</label>
              <textarea v-model="form.purpose" rows="3" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" placeholder="Meeting at Ministry" required></textarea>
              <div v-if="form.errors.purpose" class="text-red-600 text-sm mt-1">{{ form.errors.purpose }}</div>
            </div>

            <button type="submit" :disabled="form.processing" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:opacity-50">
              Submit Request
            </button>
          </form>
        </div>
      </div>

      <!-- Booking History Table -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h3 class="text-lg font-medium text-gray-900 mb-4">My Booking History</h3>
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date/Time</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Purpose</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="booking in history" :key="booking.id">
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  {{ new Date(booking.start_time).toLocaleString() }} - {{ new Date(booking.end_time).toLocaleString() }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ booking.destination }}</td>
                <td class="px-6 py-4 text-sm text-gray-500">{{ booking.purpose }}</td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full"
                    :class="{
                      'bg-yellow-100 text-yellow-800': booking.status === 'Pending',
                      'bg-green-100 text-green-800': booking.status === 'Approved',
                      'bg-red-100 text-red-800': booking.status === 'Rejected',
                      'bg-blue-100 text-blue-800': booking.status === 'Completed'
                    }">
                    {{ booking.status }}
                  </span>
                </td>
              </tr>
              <tr v-if="!history || history.length === 0">
                <td colspan="4" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">No bookings found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useForm } from '@inertiajs/vue3';
import MainLayout from '@/layouts/MainLayout.vue';
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';

const props = defineProps({
  approvedBookings: {
    type: Array,
    default: () => []
  },
  history: {
    type: Array,
    default: () => []
  }
});

const form = useForm({
  start_time: '',
  end_time: '',
  destination: '',
  purpose: '',
});

const submitBooking = () => {
  form.post(route('bookings.store'), {
    preserveScroll: true,
    onSuccess: () => form.reset(),
  });
};

const calendarEvents = computed(() => {
  return props.approvedBookings.map(booking => ({
    title: booking.destination,
    start: booking.start_time,
    end: booking.end_time,
    backgroundColor: '#ef4444', // Tailwind red-500 for approved bookings
    borderColor: '#ef4444',
  }));
});

const calendarOptions = ref({
  plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
  initialView: 'dayGridMonth',
  headerToolbar: {
    left: 'prev,next today',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek,timeGridDay'
  },
  events: calendarEvents.value,
  height: 'auto',
});
</script>
