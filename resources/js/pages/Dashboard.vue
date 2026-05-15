<script setup lang="ts">
import AuthenticatedLayout from '@/layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
import BranchDashboard from '@/components/BranchDashboard.vue';
import AdminDashboard from '@/components/AdminDashboard.vue';

// Fallback if AuthenticatedLayout isn't quite right, but it should be standard.
import { defineProps } from 'vue';

const props = defineProps<{
    userRole: string;
    bookings: any[];
}>();
</script>

<template>
    <Head title="Dashboard" />

    <AuthenticatedLayout>
        <!-- For some apps AuthenticatedLayout uses a header slot -->
        <template #header>
            <h2 class="text-xl font-semibold leading-tight text-gray-800">
                Dashboard
            </h2>
        </template>

        <div class="py-12">
            <div class="mx-auto max-w-7xl sm:px-6 lg:px-8 space-y-6">
                <!-- Branch User View -->
                <div v-if="userRole === 'branch_user'">
                    <BranchDashboard :bookings="bookings" />
                </div>

                <!-- Admin / Top Management View -->
                <div v-else-if="['transport_admin', 'top_management'].includes(userRole)">
                    <AdminDashboard :bookings="bookings" />
                </div>

                <!-- Default Fallback View -->
                <div v-else class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                    <div class="p-6 text-gray-900">
                        You're logged in, but your role ({{ userRole || 'none' }}) has no specific dashboard view.
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
