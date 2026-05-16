<template>
  <MainLayout>
    <div class="space-y-6">
      <h2 class="text-2xl font-semibold text-gray-800">Top Management Dashboard</h2>

      <!-- Statistics Section -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div class="bg-white overflow-hidden shadow rounded-lg">
          <div class="p-5">
            <div class="flex items-center">
              <div class="flex-shrink-0">
                <div class="h-10 w-10 rounded-md bg-indigo-500 flex items-center justify-center text-white font-bold text-xl">
                  B
                </div>
              </div>
              <div class="ml-5 w-0 flex-1">
                <dl>
                  <dt class="text-sm font-medium text-gray-500 truncate">Total Bookings Today</dt>
                  <dd>
                    <div class="text-lg font-medium text-gray-900">{{ stats.todayBookings }}</div>
                  </dd>
                </dl>
              </div>
            </div>
          </div>
        </div>

        <div class="bg-white overflow-hidden shadow rounded-lg">
          <div class="p-5">
            <div class="flex items-center">
              <div class="flex-shrink-0">
                <div class="h-10 w-10 rounded-md bg-green-500 flex items-center justify-center text-white font-bold text-xl">
                  A
                </div>
              </div>
              <div class="ml-5 w-0 flex-1">
                <dl>
                  <dt class="text-sm font-medium text-gray-500 truncate">Approved This Week</dt>
                  <dd>
                    <div class="text-lg font-medium text-gray-900">{{ stats.weeklyApproved }}</div>
                  </dd>
                </dl>
              </div>
            </div>
          </div>
        </div>

        <div class="bg-white overflow-hidden shadow rounded-lg">
          <div class="p-5">
            <div class="flex items-center">
              <div class="flex-shrink-0">
                <div class="h-10 w-10 rounded-md bg-red-500 flex items-center justify-center text-white font-bold text-xl">
                  R
                </div>
              </div>
              <div class="ml-5 w-0 flex-1">
                <dl>
                  <dt class="text-sm font-medium text-gray-500 truncate">Rejected This Week</dt>
                  <dd>
                    <div class="text-lg font-medium text-gray-900">{{ stats.weeklyRejected }}</div>
                  </dd>
                </dl>
              </div>
            </div>
          </div>
        </div>

        <div class="bg-white overflow-hidden shadow rounded-lg">
          <div class="p-5">
            <div class="flex items-center">
              <div class="flex-shrink-0">
                <div class="h-10 w-10 rounded-md bg-yellow-500 flex items-center justify-center text-white font-bold text-xl">
                  V
                </div>
              </div>
              <div class="ml-5 w-0 flex-1">
                <dl>
                  <dt class="text-sm font-medium text-gray-500 truncate">Total Vehicles</dt>
                  <dd>
                    <div class="text-lg font-medium text-gray-900">1 (PB-4836)</div>
                  </dd>
                </dl>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Calendar Section -->
      <div class="bg-white p-6 rounded-lg shadow-sm">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Vehicle Schedule Overview</h3>
        <FullCalendar :options="calendarOptions" />
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

const props = defineProps({
  approvedBookings: {
    type: Array,
    default: () => []
  },
  stats: {
    type: Object,
    default: () => ({
      todayBookings: 0,
      weeklyApproved: 0,
      weeklyRejected: 0
    })
  }
});

const calendarEvents = computed(() => {
  return props.approvedBookings.map(booking => ({
    title: `${booking.destination} - ${booking.user?.name || 'Unknown'}`,
    start: booking.start_time,
    end: booking.end_time,
    backgroundColor: '#4f46e5', // Tailwind indigo-600
    borderColor: '#4f46e5',
  }));
});

const calendarOptions = ref({
  plugins: [dayGridPlugin, timeGridPlugin],
  initialView: 'timeGridWeek',
  headerToolbar: {
    left: 'prev,next today',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek,timeGridDay'
  },
  events: calendarEvents.value,
  height: 'auto',
  allDaySlot: false,
});
</script>
