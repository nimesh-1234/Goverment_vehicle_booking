<script setup lang="ts">
import { computed } from 'vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
import MainLayout from '@/layouts/MainLayout.vue';

defineProps<{
    canLogin?: boolean;
    canRegister?: boolean;
    branches?: Array<{
        id: number;
        name: string;
        logo_path: string | null;
    }>;
}>();

const page = usePage();
const user = computed(() => page.props.auth?.user);
</script>

<template>
    <Head title="Home" />
    <MainLayout>
        <template #header-actions>
            <Link
                v-if="canLogin && !user"
                :href="route('login')"
                class="font-semibold hover:text-gray-200"
            >
                Log in
            </Link>

            <Link
                v-if="canRegister && !user"
                :href="route('register')"
                class="font-semibold hover:text-gray-200 ml-4"
            >
                Register
            </Link>
        </template>

        <!-- Branch Cards Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <div v-for="branch in branches" :key="branch.id" class="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300 flex flex-col items-center p-6 border border-gray-100">
                <div class="h-24 w-24 bg-gray-100 rounded-full flex items-center justify-center mb-6 overflow-hidden border-4 border-gray-50 shadow-sm">
                    <img v-if="branch.logo_path" :src="`/storage/${branch.logo_path}`" :alt="branch.name" class="h-full w-full object-cover" />
                    <span v-else class="text-4xl text-gray-400">
                        <svg class="w-12 h-12" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z" />
                        </svg>
                    </span>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-6 text-center line-clamp-2 h-14">{{ branch.name }}</h3>
                
                <!-- Conditional Buttons based on Auth Status -->
                <Link v-if="user" :href="route('dashboard')" class="w-full mt-auto">
                    <button class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2.5 px-4 rounded-lg transition-colors shadow-sm">
                        Go to Dashboard
                    </button>
                </Link>
                <Link v-else-if="canLogin" :href="route('login')" class="w-full mt-auto">
                    <button class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-4 rounded-lg transition-colors shadow-sm">
                        Login
                    </button>
                </Link>
            </div>
            
            <div v-if="!branches || branches.length === 0" class="col-span-full py-12 text-center text-gray-500">
                No branches currently registered in the system.
            </div>
        </div>
    </MainLayout>
</template>
