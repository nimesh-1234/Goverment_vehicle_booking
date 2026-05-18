<template>
  <MainLayout>
    <div class="space-y-6">
      <h2 class="text-2xl font-semibold text-gray-800">Transport Admin Dashboard</h2>

      <!-- Active Trips Section -->
      <div class="bg-white p-6 rounded-lg shadow-sm border-l-4 border-indigo-500">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Active Trip (Vehicle Status: {{ currentStatus }})</h3>
        
        <div v-if="activeTrip" class="flex flex-col md:flex-row md:items-center justify-between bg-indigo-50 p-4 rounded-md">
          <div class="mb-4 md:mb-0">
            <p class="font-semibold text-indigo-900">Destination: {{ activeTrip.destination }}</p>
            <p class="text-sm text-indigo-700">Driver: W.M. Tennakoon Banda | Vehicle: PB-4836</p>
            <p class="text-sm text-indigo-700">Requested by: {{ activeTrip.user?.name || 'Unknown User' }}</p>
            <p class="text-xs text-indigo-500 mt-1">
              Started: {{ new Date(activeTrip.start_time).toLocaleString() }}
            </p>
          </div>
          <Link
            :href="route('bookings.mark-returned', activeTrip.id)"
            method="post"
            as="button"
            class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            Mark as Returned
          </Link>
        </div>
        <div v-else class="text-gray-500 italic p-4 bg-gray-50 rounded-md">
          No active trips at the moment. The vehicle is currently available.
        </div>
      </div>

      <!-- Pending Requests Table -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Pending Booking Requests</h3>
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date/Time</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Purpose</th>
                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="request in pendingRequests" :key="request.id">
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                  {{ request.user?.name || 'Unknown' }}
                  <span class="block text-xs text-gray-500">{{ request.user?.branch?.name || '' }}</span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                  {{ new Date(request.start_time).toLocaleString() }} - <br/>
                  {{ new Date(request.end_time).toLocaleString() }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ request.destination }}</td>
                <td class="px-6 py-4 text-sm text-gray-500 max-w-xs truncate">{{ request.purpose }}</td>
                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                  <Link
                    :href="route('bookings.approve', request.id)"
                    method="post"
                    as="button"
                    class="text-green-600 hover:text-green-900 mr-4 font-semibold"
                  >
                    Approve
                  </Link>
                  <Link
                    :href="route('bookings.reject', request.id)"
                    method="post"
                    as="button"
                    class="text-red-600 hover:text-red-900 font-semibold"
                  >
                    Reject
                  </Link>
                </td>
              </tr>
              <tr v-if="!pendingRequests || pendingRequests.length === 0">
                <td colspan="5" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">No pending requests.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Approved Bookings Calendar -->
      <div class="bg-white p-6 rounded-lg shadow-sm mb-6">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Approved Bookings Calendar</h3>
        <FullCalendar :options="calendarOptions" />
      </div>

      <!-- Manage All Bookings -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Manage All Bookings</h3>
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User / Branch</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date/Time</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination & Purpose</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="booking in allBookings" :key="booking.id">
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                  <div class="font-medium">{{ booking.user?.name || 'Unknown' }}</div>
                  <div class="text-xs text-gray-500">{{ booking.branch?.name || '' }}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                  {{ new Date(booking.start_time).toLocaleString() }}<br/>
                  <span class="text-xs text-gray-400">to {{ new Date(booking.end_time).toLocaleString() }}</span>
                </td>
                <td class="px-6 py-4 text-sm text-gray-500 max-w-xs truncate">
                  <div class="font-medium text-gray-700">{{ booking.destination }}</div>
                  <div class="text-xs">{{ booking.purpose }}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full"
                    :class="{
                      'bg-yellow-100 text-yellow-800': booking.status === 'pending',
                      'bg-green-100 text-green-800': booking.status === 'approved',
                      'bg-red-100 text-red-800': booking.status === 'rejected',
                      'bg-blue-100 text-blue-800': booking.status === 'completed',
                      'bg-purple-100 text-purple-800': booking.status === 'on trip'
                    }">
                    {{ booking.status }}
                  </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                  <button @click="openBookingModal(booking)" class="text-indigo-600 hover:text-indigo-900 mr-4 font-semibold">Edit</button>
                  <Link :href="route('transport-admin.bookings.destroy', booking.id)" method="delete" as="button" class="text-red-600 hover:text-red-900 font-semibold">Delete</Link>
                </td>
              </tr>
              <tr v-if="!allBookings || allBookings.length === 0">
                <td colspan="5" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">No bookings found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Edit Booking Modal -->
    <div v-if="showBookingModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h3 class="text-lg font-medium mb-4">Edit Booking</h3>
        <form @submit.prevent="submitBooking">
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700">Destination</label>
            <input v-model="bookingForm.destination" type="text" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
            <div v-if="bookingForm.errors.destination" class="text-red-600 text-xs mt-1">{{ bookingForm.errors.destination }}</div>
          </div>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700">Purpose</label>
            <input v-model="bookingForm.purpose" type="text" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
            <div v-if="bookingForm.errors.purpose" class="text-red-600 text-xs mt-1">{{ bookingForm.errors.purpose }}</div>
          </div>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700">Start Time</label>
            <input v-model="bookingForm.start_time" type="datetime-local" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
            <div v-if="bookingForm.errors.start_time" class="text-red-600 text-xs mt-1">{{ bookingForm.errors.start_time }}</div>
          </div>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700">End Time</label>
            <input v-model="bookingForm.end_time" type="datetime-local" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
            <div v-if="bookingForm.errors.end_time" class="text-red-600 text-xs mt-1">{{ bookingForm.errors.end_time }}</div>
          </div>
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700">Status</label>
            <select v-model="bookingForm.status" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required>
              <option value="pending">Pending</option>
              <option value="approved">Approved</option>
              <option value="on trip">On Trip</option>
              <option value="completed">Completed</option>
              <option value="rejected">Rejected</option>
            </select>
          </div>
          <div class="flex justify-end space-x-3 mt-6">
            <button type="button" @click="showBookingModal = false" class="px-4 py-2 border rounded-md text-gray-700 hover:bg-gray-50">Cancel</button>
            <button type="submit" :disabled="bookingForm.processing" class="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 disabled:opacity-50">Save</button>
          </div>
        </form>
      </div>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, computed } from 'vue';
import { usePage, Link, useForm } from '@inertiajs/vue3';
import MainLayout from '@/layouts/MainLayout.vue';
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';

const props = defineProps({
  pendingRequests: {
    type: Array,
    default: () => []
  },
  activeTrip: {
    type: Object,
    default: null
  },
  allBookings: {
    type: Array,
    default: () => []
  },
  approvedBookings: {
    type: Array,
    default: () => []
  }
});

const calendarEvents = computed(() => {
  return props.approvedBookings.map(booking => ({
    title: booking.branch ? `${booking.branch.name} - ${booking.destination}` : booking.destination,
    start: booking.start_time,
    end: booking.end_time,
    backgroundColor: '#ef4444',
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

const page = usePage();
const currentStatus = computed(() => page.props.currentStatus || 'Available');

const showBookingModal = ref(false);
const bookingForm = useForm({
  id: null,
  destination: '',
  purpose: '',
  start_time: '',
  end_time: '',
  status: 'pending'
});

const openBookingModal = (booking) => {
  bookingForm.clearErrors();
  bookingForm.id = booking.id;
  bookingForm.destination = booking.destination;
  bookingForm.purpose = booking.purpose;
  // Convert '2025-05-16 14:00:00' to datetime-local format '2025-05-16T14:00'
  bookingForm.start_time = booking.start_time.replace(' ', 'T').substring(0, 16);
  bookingForm.end_time = booking.end_time.replace(' ', 'T').substring(0, 16);
  bookingForm.status = booking.status;
  showBookingModal.value = true;
};

const submitBooking = () => {
  bookingForm.put(route('transport-admin.bookings.update', bookingForm.id), {
    onSuccess: () => { showBookingModal.value = false; }
  });
};
</script>
