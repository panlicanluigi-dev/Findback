<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FIND-BACK — Dashboard</title>
    <link rel="stylesheet" href="{{ asset('css/findback.css') }}">
</head>
<body>
<div class="mobile-shell">
    <div class="dashboard-page">
        <header class="topbar">
            <div class="welcome">
                <small>Welcome back,</small>
                <strong>{{ $user->name }} 👋</strong>
            </div>
            <div class="avatar">👤</div>
        </header>

        <div class="grid">
            <div class="action-card"><div class="card-icon">⌕</div><b>Search Lost</b><small>Find misplaced assets</small></div>
            <div class="action-card"><div class="card-icon">▣</div><b>Report Item</b><small>Post a missing item</small></div>
            <div class="action-card"><div class="card-icon">◉</div><b>Found Items</b><small>Browse recovered items</small></div>
            <div class="action-card"><div class="card-icon">✓</div><b>My Reports</b><small>Track your requests</small></div>
        </div>

        <div class="section-head">
            <h3>Recent Items</h3>
            <span>View All</span>
        </div>

        @foreach($items as $item)
        <div class="item-card">
            <div class="item-thumb">{{ $item['emoji'] }}</div>
            <div>
                <b>{{ $item['name'] }}</b>
                <small>● {{ $item['location'] }}</small>
                <small>◷ {{ $item['time'] }}</small>
            </div>
        </div>
        @endforeach

        <nav class="bottom-nav">
            <div class="active">⌂<span>Home</span></div>
            <div>⌕<span>Search</span></div>
            <div>⊕<span>Report</span></div>
            <div>◷<span>Activity</span></div>
            <div>◯<span>Profile</span></div>
        </nav>
    </div>
</div>
</body>
</html>
