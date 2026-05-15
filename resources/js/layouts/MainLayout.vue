<script setup lang="ts">
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="min-h-screen bg-gray-50 flex flex-col">
        <!-- Header with moving car -->
        <header class="bg-blue-600 shadow relative overflow-hidden h-24 flex items-center justify-between px-6">
            <div class="relative z-10 text-white text-2xl font-bold flex items-center gap-4">
                <Link href="/">Vehicle Booking System</Link>
            </div>
            
            <div class="absolute inset-0 z-0 pointer-events-none opacity-50 flex items-center mt-6">
                <!-- Car SVG -->
                <svg class="h-16 w-32 text-white animate-drive-car" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.85 15.75c-.69 0-1.25-.56-1.25-1.25s.56-1.25 1.25-1.25 1.25.56 1.25 1.25-.56 1.25-1.25 1.25zm10.3 0c-.69 0-1.25-.56-1.25-1.25s.56-1.25 1.25-1.25 1.25.56 1.25 1.25-.56 1.25-1.25 1.25zM5.5 11l1.5-4.5h10L18.5 11H5.5z"/>
                </svg>
            </div>

            <div class="relative z-10 flex gap-4 text-white">
                 <slot name="header-actions" />
            </div>
        </header>

        <main class="flex-1 w-full max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <slot />
        </main>
    </div>
</template>
