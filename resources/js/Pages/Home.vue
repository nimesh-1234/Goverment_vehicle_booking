<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';

const props = defineProps({
    branches: { type: Array, default: () => [] },
    approvedBookings: { type: Array, default: () => [] }
});

const page = usePage();
const user = computed(() => page.props.auth?.user);

let pollingInterval = null;

onMounted(() => {
    // Automatically reload page data every 15 seconds quietly in the background
    pollingInterval = setInterval(() => {
        router.reload({ only: ['approvedBookings', 'branches'] });
    }, 15000); 
});

onUnmounted(() => {
    if (pollingInterval) clearInterval(pollingInterval);
});

// Modal state
const showModal = ref(false);
const selectedEvent = ref<{ title: string, start: string, end: string } | null>(null);

// Calendar Event Click Handler
const handleEventClick = (info: any) => {
    selectedEvent.value = {
        title: info.event.title,
        start: info.event.start?.toLocaleString() || 'N/A',
        end: info.event.end?.toLocaleString() || 'N/A'
    };
    showModal.value = true;
};

// Calendar Data
const calendarEvents = computed(() => {
    const now = new Date();
    return (props.approvedBookings || [])
        .filter(booking => {
            const endTime = new Date(booking.end_time);
            // ONLY keep the event if it is currently "On Trip" OR if the end time is in the future
            return booking.status === 'On Trip' || booking.status === 'on_trip' || endTime > now;
        })
        .map(booking => ({
            title: booking.branch ? `${booking.branch.name}` : 'Booking',
            start: booking.start_time,
            end: booking.end_time,
            backgroundColor: '#4f46e5',
            borderColor: '#4338ca',
            extendedProps: {
                destination: booking.destination,
                purpose: booking.purpose,
                status: booking.status
            }
        }));
});

const calendarOptions = ref({
    plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
    initialView: 'dayGridMonth',
    headerToolbar: {
        left: 'prev,next',
        center: 'title',
        right: 'today'
    },
    events: calendarEvents.value,
    height: '100%',
    eventClick: handleEventClick
});
</script>

<template>
    <div v-if="approvedBookings && approvedBookings.length > 0" class="w-full">
        <div v-for="booking in approvedBookings.filter(b => b.status === 'On Trip' || b.status === 'on_trip')" :key="booking.id" class="bg-red-600 text-white text-center py-2 font-bold flex flex-wrap justify-center items-center gap-4 w-full">
            <span>Vehicle: {{ booking.vehicle_no || 'N/A' }} | Driver: {{ booking.driver_name || 'N/A' }}</span>
            <span class="bg-red-800 px-2 py-1 rounded text-sm">ON TRIP</span>
        </div>
    </div>
    <Head title="Home" />
    
    <div class="min-h-screen bg-gray-50 font-sans">
        
        <!-- 1. Top Navigation / Header -->
        <header class="bg-white shadow-sm sticky top-0 z-40">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <!-- Left: Logo & Title -->
                    <div class="flex items-center space-x-3">
                        <img src="/logo.png" alt="Logo" class="h-10 w-auto object-contain bg-gray-100 rounded-full" onerror="this.style.display='none'" />
                        <span class="font-bold text-xl text-blue-950 tracking-tight">Lunugamwehera Divisional Secretariat</span>
                    </div>

                    <!-- Right: Auth Links -->
                    <div class="flex items-center space-x-6">
                        <template v-if="user">
                            <Link :href="route('dashboard')" class="text-sm font-semibold text-gray-600 hover:text-indigo-600 transition">
                                Dashboard
                            </Link>
                            <Link :href="route('logout')" method="post" as="button" class="text-sm font-semibold text-gray-600 hover:text-red-600 transition">
                                Logout
                            </Link>
                        </template>
                        <template v-else>
                            <Link :href="route('login')" class="text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-700 px-5 py-2 rounded-lg transition shadow-sm">
                                Login
                            </Link>
                        </template>
                    </div>
                </div>
            </div>
        </header>

        <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
            
            <!-- 2. Hero Section (Split Layout) -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16 lg:h-[450px]">
                
                <!-- Left Column (Animation & Tagline) (Light Theme) -->
                <div class="bg-slate-50 border-0 rounded-2xl shadow-xl relative overflow-hidden flex flex-col justify-center items-center p-8 h-96 lg:h-full">
                    <div class="relative z-10 text-center mb-16">
                        <h1 class="text-4xl lg:text-5xl font-extrabold text-gray-900 mb-4 tracking-tight drop-shadow-sm">
                            Lunugamwehera Divisional <br/><span class="text-indigo-600">Secretariat</span>
                        </h1>
                        <p class="text-gray-600 text-lg max-w-md mx-auto">
                            Seamlessly book, track, and manage government vehicles with our state-of-the-art platform.
                        </p>
                    </div>
                    
                    <!-- Road and Car Animation -->
                    <div class="absolute bottom-10 w-full h-24 bg-gray-800 flex items-center justify-start overflow-hidden border-t-4 border-b-4 border-gray-900 shadow-inner">
                        <!-- Road Dashed Line -->
                        <div class="absolute w-full border-t-4 border-dashed border-white opacity-50 top-1/2 transform -translate-y-1/2"></div>
                        <!-- Car -->
                        <div class="text-6xl relative z-10 drop-shadow-xl select-none w-full flex">
                             <div class="car-wrapper">🚗</div>
                        </div>
                    </div>
                </div>

                <!-- Right Column (Calendar) -->
                <div class="bg-white rounded-2xl shadow-xl p-6 border border-gray-100 flex flex-col h-96 lg:h-full">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-6 h-6 mr-2 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                        Approved Bookings
                    </h2>
                    <div class="flex-grow overflow-hidden fc-compact text-sm">
                        <FullCalendar :options="calendarOptions" />
                    </div>
                </div>
            </div>

            <!-- 4. Branches Section -->
            <div class="mt-8">
                <div class="text-center mb-10">
                    <h2 class="text-3xl font-extrabold text-gray-900 tracking-tight">Our Branches</h2>
                    <p class="mt-2 text-gray-500">Select branch to login and request a vehicle.</p>
                </div>
                
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                    <div v-for="branch in branches" :key="branch.id" class="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 flex flex-col items-center p-8 border border-gray-100 group">
                        <div class="h-24 w-24 bg-gray-50 rounded-full flex items-center justify-center mb-6 overflow-hidden border-4 border-gray-100 shadow-sm group-hover:border-indigo-100 transition-colors">
                            <img v-if="branch.logo_path" :src="`/storage/${branch.logo_path}`" :alt="branch.name" class="h-full w-full object-cover" />
                            <span v-else class="text-4xl text-gray-300">
                                <svg class="w-12 h-12" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z" />
                                </svg>
                            </span>
                        </div>
                        <h3 class="text-lg font-bold text-gray-800 mb-6 text-center line-clamp-2 h-14 w-full">{{ branch.name }}</h3>
                        
                        <!-- Conditional Buttons based on Auth Status -->
                        <div class="mt-4 w-full mt-auto">
                            <template v-if="$page.props.auth.user">
                                <Link v-if="$page.props.auth.user.branch_id == branch.id" href="/dashboard" class="block w-full text-center bg-green-600 text-white py-2 rounded hover:bg-green-700 transition">
                                    Go to Dashboard
                                </Link>
                                <button v-else disabled class="block w-full text-center bg-gray-400 text-white py-2 rounded cursor-not-allowed opacity-75 flex justify-center items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" /></svg>
                                    Locked 🔒
                                </button>
                            </template>
                            
                            <template v-else>
                                <Link :href="`/login?branch_id=${branch.id}`" class="block w-full text-center bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition">
                                    Login
                                </Link>
                            </template>
                        </div>
                    </div>
                    
                    <div v-if="!branches || branches.length === 0" class="col-span-full py-16 text-center text-gray-500 bg-white rounded-xl shadow-sm border border-gray-100">
                        <svg class="mx-auto h-12 w-12 text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
                        <p class="text-lg font-medium">No branches currently registered in the system.</p>
                    </div>
                </div>
            </div>
        </main>

        <footer class="bg-white border-t border-gray-200 mt-16">
            <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row justify-between items-center gap-4 text-sm text-gray-500">
                <div>
                    © 2026 Lunugamwehera Divisional Secretariat. All Rights Reserved.
                </div>
                <div class="font-medium text-gray-700">
                    Designed & Developed by <span class="text-blue-600 font-bold">Nimesh Dilshan</span>
                </div>
            </div>
        </footer>
    </div>

    <!-- 3. Interactive Calendar (Popup/Modal) -->
    <div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center p-4">
        <!-- Backdrop -->
        <div class="fixed inset-0 bg-gray-900 bg-opacity-60 backdrop-blur-sm transition-opacity" @click="showModal = false"></div>
        
        <!-- Modal Panel -->
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden max-w-md w-full relative z-10 transform transition-all">
            <div class="bg-indigo-600 px-6 py-5 flex justify-between items-center">
                <h3 class="text-xl font-bold text-white flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    Booking Details
                </h3>
                <button @click="showModal = false" class="text-indigo-200 hover:text-white transition-colors focus:outline-none rounded-full p-1 hover:bg-indigo-700">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            
            <div class="p-6">
                <div v-if="selectedEvent" class="space-y-5">
                    <div>
                        <span class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1">Destination & Branch</span>
                        <span class="block text-lg text-gray-900 font-semibold">{{ selectedEvent.title }}</span>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div class="bg-indigo-50 p-4 rounded-xl border border-indigo-100">
                            <span class="block text-xs font-bold text-indigo-500 uppercase tracking-wider mb-1">Start Time</span>
                            <span class="block text-sm text-indigo-900 font-medium">{{ selectedEvent.start }}</span>
                        </div>
                        <div class="bg-indigo-50 p-4 rounded-xl border border-indigo-100">
                            <span class="block text-xs font-bold text-indigo-500 uppercase tracking-wider mb-1">End Time</span>
                            <span class="block text-sm text-indigo-900 font-medium">{{ selectedEvent.end }}</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="bg-gray-50 px-6 py-4 flex justify-end border-t border-gray-100">
                <button @click="showModal = false" class="bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2 px-6 rounded-lg transition-colors shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    Close
                </button>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* CSS Car Animation */
.car-wrapper {
    display: inline-block;
    /* Start from far right, move to far left over 10s */
    animation: driveForward 10s linear infinite; 
}
@keyframes driveForward {
    0% { transform: translateX(100vw); }  /* Start off-screen Right */
    100% { transform: translateX(-100vw); } /* End off-screen Left */
}

/* Compact Calendar Styling for the Grid Column */
.fc-compact :deep(.fc-header-toolbar) {
    margin-bottom: 0.75rem !important;
}
.fc-compact :deep(.fc-toolbar-title) {
    font-size: 1.15rem !important;
    font-weight: 700 !important;
    color: #374151;
}
.fc-compact :deep(.fc-button) {
    padding: 0.25rem 0.6rem !important;
    font-size: 0.875rem !important;
    background-color: #f3f4f6 !important;
    border-color: #d1d5db !important;
    color: #4b5563 !important;
    text-transform: capitalize !important;
    transition: all 0.2s;
}
.fc-compact :deep(.fc-button:hover) {
    background-color: #e5e7eb !important;
    color: #111827 !important;
}
.fc-compact :deep(.fc-button-active) {
    background-color: #4f46e5 !important;
    border-color: #4f46e5 !important;
    color: white !important;
}
.fc-compact :deep(.fc-view-harness) {
    height: 100% !important;
}
.fc-compact :deep(.fc-scrollgrid) {
    border-radius: 0.5rem;
    border-color: #e5e7eb !important;
    overflow: hidden;
}
.fc-compact :deep(th) {
    padding: 0.5rem 0 !important;
    background-color: #f9fafb;
    font-weight: 600;
    color: #4b5563;
    border-color: #e5e7eb !important;
}
.fc-compact :deep(td) {
    border-color: #e5e7eb !important;
}
.fc-compact :deep(.fc-event) {
    cursor: pointer;
    transition: transform 0.1s, box-shadow 0.1s;
}
.fc-compact :deep(.fc-event:hover) {
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
</style>