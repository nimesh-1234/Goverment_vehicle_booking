<template>
  <MainLayout>
    <div class="space-y-6">
      <h2 class="text-2xl font-semibold text-gray-800">Super Admin Dashboard</h2>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- Branches Management -->
        <div class="bg-white p-6 rounded-lg shadow-sm">
          <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-medium text-gray-900">Manage Branches</h3>
            <button @click="openBranchModal()" class="text-sm bg-indigo-600 text-white px-3 py-1 rounded hover:bg-indigo-700">Add Branch</button>
          </div>
          
          <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
                  <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Actions</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="branch in branches" :key="branch.id">
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ branch.name }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button @click="openBranchModal(branch)" class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</button>
                    <Link :href="route('super-admin.branches.destroy', branch.id)" method="delete" as="button" class="text-red-600 hover:text-red-900">Delete</Link>
                  </td>
                </tr>
                <tr v-if="!branches || branches.length === 0">
                  <td colspan="2" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">No branches found.</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Users Management -->
        <div class="bg-white p-6 rounded-lg shadow-sm">
          <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-medium text-gray-900">Manage Users</h3>
            <button @click="openUserModal()" class="text-sm bg-indigo-600 text-white px-3 py-1 rounded hover:bg-indigo-700">Add User</button>
          </div>
          
          <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
                  <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Actions</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="user in users" :key="user.id">
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ user.name }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ user.role }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button @click="openUserModal(user)" class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</button>
                    <Link :href="route('super-admin.users.destroy', user.id)" method="delete" as="button" class="text-red-600 hover:text-red-900">Delete</Link>
                  </td>
                </tr>
                <tr v-if="!users || users.length === 0">
                  <td colspan="3" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">No users found.</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Simplified Modals implementation -->
      <div v-if="showBranchModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-lg p-6 w-96">
          <h3 class="text-lg font-medium mb-4">{{ branchForm.id ? 'Edit Branch' : 'Add Branch' }}</h3>
          <form @submit.prevent="submitBranch">
            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700">Name</label>
              <input v-model="branchForm.name" type="text" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
              <div v-if="branchForm.errors.name" class="text-red-600 text-xs mt-1">{{ branchForm.errors.name }}</div>
            </div>
            <div class="flex justify-end space-x-3">
              <button type="button" @click="showBranchModal = false" class="px-4 py-2 border rounded-md text-gray-700 hover:bg-gray-50">Cancel</button>
              <button type="submit" :disabled="branchForm.processing" class="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 disabled:opacity-50">Save</button>
            </div>
          </form>
        </div>
      </div>

      <div v-if="showUserModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-lg p-6 w-96">
          <h3 class="text-lg font-medium mb-4">{{ userForm.id ? 'Edit User' : 'Add User' }}</h3>
          <form @submit.prevent="submitUser">
            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700">Name</label>
              <input v-model="userForm.name" type="text" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
              <div v-if="userForm.errors.name" class="text-red-600 text-xs mt-1">{{ userForm.errors.name }}</div>
            </div>
            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700">Email</label>
              <input v-model="userForm.email" type="email" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required />
              <div v-if="userForm.errors.email" class="text-red-600 text-xs mt-1">{{ userForm.errors.email }}</div>
            </div>
            <div class="mb-4" v-if="!userForm.id">
              <label class="block text-sm font-medium text-gray-700">Password</label>
              <input v-model="userForm.password" type="password" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" :required="!userForm.id" />
              <div v-if="userForm.errors.password" class="text-red-600 text-xs mt-1">{{ userForm.errors.password }}</div>
            </div>
            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700">Role</label>
              <select v-model="userForm.role" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required>
                <option value="branch_user">Branch User</option>
                <option value="transport_admin">Transport Admin</option>
                <option value="top_management">Top Management</option>
                <option value="super_admin">Super Admin</option>
              </select>
            </div>
            <div class="mb-4" v-if="userForm.role === 'branch_user'">
              <label class="block text-sm font-medium text-gray-700">Branch</label>
              <select v-model="userForm.branch_id" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                <option value="">Select Branch</option>
                <option v-for="branch in branches" :key="branch.id" :value="branch.id">{{ branch.name }}</option>
              </select>
            </div>
            <div class="flex justify-end space-x-3">
              <button type="button" @click="showUserModal = false" class="px-4 py-2 border rounded-md text-gray-700 hover:bg-gray-50">Cancel</button>
              <button type="submit" :disabled="userForm.processing" class="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 disabled:opacity-50">Save</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref } from 'vue';
import { useForm, Link } from '@inertiajs/vue3';
import MainLayout from '@/layouts/MainLayout.vue';

const props = defineProps({
  branches: {
    type: Array,
    default: () => []
  },
  users: {
    type: Array,
    default: () => []
  }
});

// Branch Form
const showBranchModal = ref(false);
const branchForm = useForm({
  id: null,
  name: ''
});

const openBranchModal = (branch = null) => {
  branchForm.clearErrors();
  if (branch) {
    branchForm.id = branch.id;
    branchForm.name = branch.name;
  } else {
    branchForm.reset();
    branchForm.id = null;
  }
  showBranchModal.value = true;
};

const submitBranch = () => {
  if (branchForm.id) {
    branchForm.put(route('super-admin.branches.update', branchForm.id), {
      onSuccess: () => { showBranchModal.value = false; }
    });
  } else {
    branchForm.post(route('super-admin.branches.store'), {
      onSuccess: () => { showBranchModal.value = false; }
    });
  }
};

// User Form
const showUserModal = ref(false);
const userForm = useForm({
  id: null,
  name: '',
  email: '',
  password: '',
  role: 'branch_user',
  branch_id: null
});

const openUserModal = (user = null) => {
  userForm.clearErrors();
  if (user) {
    userForm.id = user.id;
    userForm.name = user.name;
    userForm.email = user.email;
    userForm.role = user.role;
    userForm.branch_id = user.branch_id;
    userForm.password = ''; // Don't fill password on edit
  } else {
    userForm.reset();
    userForm.id = null;
  }
  showUserModal.value = true;
};

const submitUser = () => {
  if (userForm.id) {
    userForm.put(route('super-admin.users.update', userForm.id), {
      onSuccess: () => { showUserModal.value = false; }
    });
  } else {
    userForm.post(route('super-admin.users.store'), {
      onSuccess: () => { showUserModal.value = false; }
    });
  }
};
</script>
