<?php

namespace App\Http\Controllers;

use App\Models\Branch;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;

class SuperAdminController extends Controller
{
    // --- BRANCHES ---

    public function storeBranch(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255', 'unique:branches,name'],
        ]);

        Branch::create($validated);

        return redirect()->back()->with('success', 'Branch created successfully.');
    }

    public function updateBranch(Request $request, Branch $branch): RedirectResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255', 'unique:branches,name,' . $branch->id],
        ]);

        $branch->update($validated);

        return redirect()->back()->with('success', 'Branch updated successfully.');
    }

    public function destroyBranch(Branch $branch): RedirectResponse
    {
        $branch->delete();

        return redirect()->back()->with('success', 'Branch deleted successfully.');
    }

    // --- USERS ---

    public function storeUser(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'username' => ['nullable', 'string', 'max:255', 'unique:users,username'],
            'password' => ['required', Rules\Password::defaults()],
            'role' => ['required', 'string', 'in:branch_user,transport_admin,top_management,super_admin'],
            'branch_id' => ['nullable', 'exists:branches,id'],
        ]);

        User::create([
            'name' => $validated['name'] ?? null,
            'email' => $validated['email'] ?? null,
            'username' => $validated['username'] ?? null,
            'password' => Hash::make($validated['password']),
            'role' => $validated['role'] ?? null,
            'branch_id' => $validated['branch_id'] ?? null,
        ]);

        return redirect()->back()->with('success', 'User created successfully.');
    }

    public function updateUser(Request $request, User $user): RedirectResponse
    {
        $rules = [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class.',email,'.$user->id],
            'username' => ['nullable', 'string', 'max:255', 'unique:users,username,'.$user->id],
            'role' => ['required', 'string', 'in:branch_user,transport_admin,top_management,super_admin'],
            'branch_id' => ['nullable', 'exists:branches,id'],
        ];

        // Only validate password if it is being changed
        if ($request->filled('password')) {
            $rules['password'] = ['required', Rules\Password::defaults()];
        }

        $validated = $request->validate($rules);

        $dataToUpdate = [
            'name' => $validated['name'] ?? $user->name,
            'email' => $validated['email'] ?? $user->email,
            'username' => $validated['username'] ?? null,
            'role' => $validated['role'] ?? $user->role,
            'branch_id' => $validated['branch_id'] ?? null,
        ];

        if ($request->filled('password')) {
            $dataToUpdate['password'] = Hash::make($validated['password']);
        }

        $user->update($dataToUpdate);

        return redirect()->back()->with('success', 'User updated successfully.');
    }

    public function destroyUser(User $user): RedirectResponse
    {
        // Prevent deleting yourself
        if (auth()->id() === $user->id) {
            return redirect()->back()->withErrors(['error' => 'You cannot delete your own account.']);
        }

        $user->delete();

        return redirect()->back()->with('success', 'User deleted successfully.');
    }
}
