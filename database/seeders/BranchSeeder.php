<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Branch;

class BranchSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        
        $branches = [
            'Establishment Branch',
            'Land Branch',
            'Soacial Services Branch',
            'Accounts Branch',
            'Registration of Persons branch',
            'Registar Branch',
            'Development Branch',
            'Field Branch',
            'Grama Niladhari Branch',
            'preja Shakthi Branch',
            'Samurdhi Branch (සමෘද්ධි)'
        ];

        foreach ($branches as $branch) {
            Branch::create([
                'name' => $branch,
                'logo_path' => null 
            ]);
        }
    }
}