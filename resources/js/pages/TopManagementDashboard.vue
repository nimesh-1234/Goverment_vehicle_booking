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

const calendarEvents = computed(() => {
  return props.approvedBookings.map(booking => ({
    // If you'd like to show the branch name on the global calendar, you can use:
    // title: `${booking.branch ? booking.branch.name + ' - ' : ''}${booking.destination}`,
    title: booking.destination,
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
</script>