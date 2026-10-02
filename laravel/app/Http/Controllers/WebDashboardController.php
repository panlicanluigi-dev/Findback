<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;

class WebDashboardController extends Controller
{
    public function index()
    {
        return view('dashboard', [
            'user' => Auth::user(),
            'items' => [
                [
                    'name' => 'AirPods Pro (2nd Gen)',
                    'location' => 'Science Library - Hallway',
                    'time' => 'Posted 10m ago',
                    'emoji' => '🎧',
                ],
                [
                    'name' => 'Hydro Flask Bottle',
                    'location' => 'Student Union Gym',
                    'time' => 'Posted 2 hours ago',
                    'emoji' => '🥤',
                ],
            ],
        ]);
    }
}
