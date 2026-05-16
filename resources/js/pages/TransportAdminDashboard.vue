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
    </div>
  </MainLayout>
</template>

<script setup>
import { computed } from 'vue';
import { usePage, Link } from '@inertiajs/vue3';
import MainLayout from '@/layouts/MainLayout.vue';

const props = defineProps({
  pendingRequests: {
    type: Array,
    default: () => []
  },
  activeTrip: {
    type: Object,
    default: null
  }
});

const page = usePage();
const currentStatus = computed(() => page.props.currentStatus || 'Available');
</script>
