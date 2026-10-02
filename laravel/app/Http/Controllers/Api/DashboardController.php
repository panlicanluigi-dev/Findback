<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        return response()->json([
            'user' => $request->user(),
            'items' => [
                [
                    'name' => 'AirPods Pro (2nd Gen)',
                    'location' => 'Science Library - Hallway',
                    'time' => 'Posted 10m ago',
                    'icon' => 'headphones',
                ],
                [
                    'name' => 'Hydro Flask Bottle',
                    'location' => 'Student Union Gym',
                    'time' => 'Posted 2 hours ago',
                    'icon' => 'bottle',
                ],
            ],
        ]);
    }
}
