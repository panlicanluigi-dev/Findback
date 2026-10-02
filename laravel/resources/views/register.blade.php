<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FIND-BACK — Register</title>
    <link rel="stylesheet" href="{{ asset('css/findback.css') }}">
</head>
<body>
<div class="mobile-shell">
    <div class="auth-page">
        <div class="logo-circle">⌕</div>
        <h1>FINDBACK</h1>
        <div class="subtitle">CAMPUS LOST & FOUND</div>

        <h2>Create your account</h2>
        <p class="muted">Register with your university credentials to report or find misplaced items.</p>

        <form method="POST" action="{{ route('register.store') }}">
            @csrf

            <label>Full Name</label>
            <div class="input-wrap"><span>👤</span><input name="name" value="{{ old('name') }}" placeholder="Alex Mercer" required></div>
            @error('name') <div class="error">{{ $message }}</div> @enderror

            <label>University Email</label>
            <div class="input-wrap"><span>✉</span><input type="email" name="email" value="{{ old('email') }}" placeholder="alex.mercer@university.edu" required></div>
            @error('email') <div class="error">{{ $message }}</div> @enderror

            <label>Password</label>
            <div class="input-wrap"><span>🔒</span><input type="password" name="password" placeholder="Minimum 8 characters" required></div>

            <label>Confirm Password</label>
            <div class="input-wrap"><span>🔒</span><input type="password" name="password_confirmation" placeholder="Repeat password" required></div>
            @error('password') <div class="error">{{ $message }}</div> @enderror

            <button type="submit">Create Account</button>
        </form>

        <p class="footer-note">FIND-BACK • Campus Lost & Found Research Prototype</p>
    </div>
</div>
</body>
</html>
