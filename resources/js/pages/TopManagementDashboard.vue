<template>
  <MainLayout>
    <div class="space-y-6">
      <h2 class="text-2xl font-semibold text-gray-800">Top Management Dashboard</h2>

      <!-- Global Calendar Section -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Approved Bookings Calendar</h3>
        <FullCalendar :options="calendarOptions" />
      </div>
    </div>

    <!-- Booking Details Modal -->
    <div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center p-4">
      <div class="fixed inset-0 bg-gray-900 bg-opacity-60 backdrop-blur-sm transition-opacity" @click="showModal = false"></div>
      
      <div class="bg-white rounded-2xl shadow-2xl overflow-hidden max-w-md w-full relative z-10 transform transition-all">
        <div class="bg-indigo-600 px-6 py-5 flex justify-between items-center">
          <h3 class="text-xl font-bold text-white">Booking Details</h3>
          <button @click="showModal = false" class="text-indigo-200 hover:text-white transition-colors focus:outline-none rounded-full p-1 hover:bg-indigo-700">
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        
        <div class="p-6">
          <div v-if="selectedBooking" class="space-y-4">
            <div>
              <span class="block text-xs font-bold text-gray-500 uppercase">Destination</span>
              <span class="block text-lg text-gray-900 font-semibold">{{ selectedBooking.destination }}</span>
            </div>
            
            <div>
              <span class="block text-xs font-bold text-gray-500 uppercase">Branch</span>
              <span class="block text-md text-gray-900 font-medium">{{ selectedBooking.branch_name }}</span>
            </div>
            
            <div>
              <span class="block text-xs font-bold text-gray-500 uppercase">Purpose</span>
              <span class="block text-md text-gray-700">{{ selectedBooking.purpose }}</span>
            </div>
            
            <div class="grid grid-cols-2 gap-4 pt-2">
              <div class="bg-indigo-50 p-3 rounded-lg border border-indigo-100">
                <span class="block text-xs font-bold text-indigo-500 uppercase">Start Time</span>
                <span class="block text-sm text-indigo-900">{{ new Date(selectedBooking.start).toLocaleString() }}</span>
              </div>
              <div class="bg-indigo-50 p-3 rounded-lg border border-indigo-100">
                <span class="block text-xs font-bold text-indigo-500 uppercase">End Time</span>
                <span class="block text-sm text-indigo-900">{{ new Date(selectedBooking.end).toLocaleString() }}</span>
              </div>
            </div>
            
            <div v-if="selectedBooking.status === 'Approved' || selectedBooking.status === 'On Trip' || selectedBooking.status === 'on_trip'" class="mt-4 pt-4 border-t border-gray-100 grid grid-cols-2 gap-4">
              <div>
                <span class="block text-xs font-bold text-gray-500 uppercase">Vehicle No.</span>
                <span class="block text-sm text-gray-900 font-medium">{{ selectedBooking.vehicle_no || 'Pending' }}</span>
              </div>
              <div>
                <span class="block text-xs font-bold text-gray-500 uppercase">Driver Name</span>
                <span class="block text-sm text-gray-900 font-medium">{{ selectedBooking.driver_name || 'Pending' }}</span>
              </div>
            </div>
          </div>
        </div>
        
        <div class="bg-gray-50 px-6 py-4 flex justify-end border-t border-gray-100">
          <button @click="showModal = false" class="bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2 px-6 rounded-lg transition-colors shadow-sm">
            Close
          </button>
        </div>
      </div>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, computed } from 'vue';
import MainLayout from '@/layouts/MainLayout.vue';
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';

const props = defineProps({
  approvedBookings: {
    type: Array,
    default: () => []
  }
});

let pollingInterval = null;

onMounted(() => {
    // Automatically reload page data every 15 seconds quietly in the background
    pollingInterval = setInterval(() => {
        router.reload({ only: ['approvedBookings'] });
    }, 15000); 
});

onUnmounted(() => {
    if (pollingInterval) clearInterval(pollingInterval);
});

const selectedBooking = ref(null);
const showModal = ref(false);

const handleEventClick = (clickInfo) => {
    selectedBooking.value = {
        title: clickInfo.event.title,
        start: clickInfo.event.startStr,
        end: clickInfo.event.endStr,
        ...clickInfo.event.extendedProps
    };
    showModal.value = true;
};

const calendarEvents = computed(() => {
  return props.approvedBookings.map(booking => ({
    // If you'd like to show the branch name on the global calendar, you can use:
    // title: `${booking.branch ? booking.branch.name + ' - ' : ''}${booking.destination}`,
    title: booking.destination,
    start: booking.start_time,
    end: booking.end_time,
    backgroundColor: '#ef4444',
    borderColor: '#ef4444',
    extendedProps: {
      destination: booking.destination,
      purpose: booking.purpose,
      status: booking.status,
      vehicle_no: booking.vehicle_no,
      driver_name: booking.driver_name,
      branch_name: booking.branch ? booking.branch.name : 'Unknown Branch'
    }
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
  eventClick: handleEventClick
});
</script>