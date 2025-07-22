<?php

namespace Database\Seeders;

use App\Models\Todo;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TodoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = \Faker\Factory::create();

        for ($i = 1; $i < 12; $i++) {
            Todo::create([
                "title" => $faker->title,
                "description" => $faker->sentence,
                "isComplete" => $faker->boolean,
            ]);
        }
    }
}
