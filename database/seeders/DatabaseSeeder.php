<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Branch;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Truncate/clear existing records safely to ensure a clean slate
        Schema::disableForeignKeyConstraints();
        User::truncate();
        Branch::truncate();
        Schema::enableForeignKeyConstraints();

        // 2. Create the default Headquarters branch to satisfy foreign key requirements
        $headquarters = Branch::create([
            'name' => 'Headquarters',
        ]);

        // 3. Create the main Super Admin user
        User::create([
            'name' => 'Super Admin',
            'username' => 'superadmin', // required by your schema
            'email' => 'superadmin@gov.lk',
            'password' => Hash::make('password'),
            'role' => 'super_admin', // As per your Enum definition
            'branch_id' => $headquarters->id, // Linked to the newly created branch
        ]);
    }
}
