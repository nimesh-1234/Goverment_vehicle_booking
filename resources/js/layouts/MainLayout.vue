<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Global Status Banner -->
    <div
      v-if="currentStatus"
      :class="statusClasses"
      class="w-full text-white text-center py-2 font-semibold shadow-sm flex items-center justify-center space-x-4 transition-colors duration-500"
    >
      <span>Vehicle: {{ vehicleName }} | Driver: {{ driverName }}</span>
      <span class="px-2 py-0.5 rounded bg-black/20 text-sm uppercase tracking-wider">
        {{ currentStatus }}
      </span>
    </div>

    <!-- Navigation (Placeholder for app nav) -->
    <nav class="bg-white border-b border-gray-100 shadow-sm">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex">
            <!-- Logo -->
            <div class="shrink-0 flex items-center">
              <Link href="/" class="font-bold text-xl text-indigo-600">
                Gov Transport System
              </Link>
            </div>
          </div>
          <div class="hidden sm:flex sm:items-center sm:ml-6">
            <span class="text-sm text-gray-500 mr-4">{{ user?.name }} ({{ user?.role }})</span>
            <Link :href="route('logout')" method="post" as="button" class="text-sm text-gray-700 hover:text-gray-900">
              Logout
            </Link>
          </div>
        </div>
      </div>
    </nav>

    <!-- Page Content -->
    <main class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <slot />
      </div>
    </main>
  </div>
</template>

<script setup>
import { computed, onMounted, onUnmounted } from 'vue';
import { usePage, router, Link } from '@inertiajs/vue3';

const page = usePage();
const user = computed(() => page.props.auth?.user);

// Defaulting to requested vehicle/driver info if not provided by backend yet
const currentStatus = computed(() => page.props.currentStatus || 'Available');
const vehicleName = computed(() => page.props.vehicleName || 'PB-4836');
const driverName = computed(() => page.props.driverName || 'W.M. Tennakoon Banda');

const statusClasses = computed(() => {
  return currentStatus.value === 'On Trip' ? 'bg-red-600' : 'bg-green-600';
});

let intervalId = null;

onMounted(() => {
  // Poll for status every 30 seconds
  intervalId = setInterval(() => {
    router.reload({ only: ['currentStatus'], preserveState: true, preserveScroll: true });
  }, 30000);
});

onUnmounted(() => {
  if (intervalId) clearInterval(intervalId);
});
</script>
