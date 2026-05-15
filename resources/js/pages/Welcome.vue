<script setup>
import { ref, onMounted } from 'vue';
import { Head, Link } from '@inertiajs/vue3';
import AnimatedLayout from '@/Layouts/AnimatedLayout.vue';

defineProps({
    canLogin: {
        type: Boolean,
    },
    canRegister: {
        type: Boolean,
    },
});

const vehicleStatus = ref('Loading...');

onMounted(async () => {
    try {
        const response = await fetch('/vehicle-status');
        const data = await response.json();
        vehicleStatus.value = data.status;
    } catch (error) {
        console.error("Failed to fetch vehicle status:", error);
        vehicleStatus.value = 'Unknown';
    }
});

const branches = [
    { id: 1, name: 'Central Headquarters', logo: '🏢' },
    { id: 2, name: 'North Branch', logo: '🏛️' },
    { id: 3, name: 'East Branch', logo: '🏤' },
    { id: 4, name: 'West Branch', logo: '🏦' },
];
</script>

<template>
    <Head title="Welcome" />
    <AnimatedLayout>
        <!-- Live Status Banner -->
        <div class="mb-8 p-6 rounded-lg shadow-lg text-center"
             :class="{
                 'bg-green-100 text-green-800 border-2 border-green-500': vehicleStatus === 'Available',
                 'bg-red-100 text-red-800 border-2 border-red-500': vehicleStatus === 'On Trip',
                 'bg-gray-100 text-gray-800 border-2 border-gray-300': vehicleStatus === 'Loading...' || vehicleStatus === 'Unknown'
             }">
            <h2 class="text-3xl font-extrabold tracking-tight">
                Current Vehicle Status: <span class="uppercase">{{ vehicleStatus }}</span>
            </h2>
            <p class="mt-2 text-lg">
                {{ vehicleStatus === 'Available' ? 'The official vehicle is currently available for booking.' : 
                   vehicleStatus === 'On Trip' ? 'The official vehicle is currently engaged in a trip.' : 
                   'Fetching latest status...' }}
            </p>
        </div>

        <!-- Branch Cards Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div v-for="branch in branches" :key="branch.id" class="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300 flex flex-col items-center p-6">
                <div class="text-6xl mb-4">{{ branch.logo }}</div>
                <h3 class="text-xl font-semibold text-gray-800 mb-6 text-center">{{ branch.name }}</h3>
                <Link v-if="canLogin" :href="route('login')" class="w-full">
                    <button class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition-colors">
                        Branch Login
                    </button>
                </Link>
            </div>
        </div>
    </AnimatedLayout>
</template>
