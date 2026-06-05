<script setup lang="ts">
import NavUser from '@/components/NavUser.vue';
import {
    Sidebar,
    SidebarContent,
    SidebarFooter,
    SidebarHeader,
} from '@/components/ui/sidebar';
</script>

<template>
    <Sidebar collapsible="icon" variant="inset">
        
        <SidebarHeader>
        </SidebarHeader>

        <SidebarContent>
        </SidebarContent>

        <SidebarFooter>
            <NavUser />
        </SidebarFooter>
        
    </Sidebar>
    <slot />
</template>