<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="min-h-screen bg-gray-100">
        <!-- Header with Moving Car -->
        <header class="bg-white shadow relative overflow-hidden h-24 flex items-center">
            <div class="absolute inset-0 border-b-4 border-gray-800" style="top: auto; bottom: 0;"></div>
            
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full flex justify-between items-center relative z-10">
                <h1 class="text-2xl font-bold text-gray-900">
                    GovVehicle System
                </h1>
                
                <nav class="space-x-4" v-if="$page.props.auth.user">
                    <Link :href="route('dashboard')" class="text-gray-700 hover:text-gray-900">Dashboard</Link>
                </nav>
                <nav class="space-x-4" v-else>
                    <Link :href="route('login')" class="text-gray-700 hover:text-gray-900">Log in</Link>
                </nav>
            </div>

            <!-- Moving Car SVG -->
            <div class="absolute bottom-1 animate-drive-car">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-24 text-blue-600" viewBox="0 0 24 24" fill="currentColor" stroke="none">
                    <path d="M19 8l-2-4H7L5 8H3v8h2v2h2v-2h10v2h2v-2h2V8h-2zm-9-2h4l1.5 3H7.5L10 6zm-5 8c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm14 0c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z" />
                </svg>
            </div>
        </header>

        <!-- Main Content -->
        <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <slot />
        </main>
    </div>
</template>
