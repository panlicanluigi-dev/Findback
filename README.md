# FIND-BACK Research App

Two-page implementation based on the supplied reference:
1. Register page
2. Dashboard page after registration/login

Stack:
- Web: Laravel 13 + Blade + CSS
- Mobile: Flutter/Dart
- Backend: Laravel JSON API for the Flutter app

The dashboard is intentionally limited to the two-page research prototype. The cards and recent items are sample data that can later be connected to your research database.

## WEB SETUP

Create a fresh Laravel 13 project first:

```bash
laravel new findback-web
cd findback-web
php artisan install:api
```

Copy the files from `laravel/` in this package into the matching folders of the fresh project.

Create the database, then run:

```bash
php artisan migrate
php artisan serve
```

Open:

```text
http://127.0.0.1:8000/register
```

The register form creates the account and sends the user directly to the dashboard.

For MySQL, update `.env` with your database settings.

## MOBILE SETUP

Create a Flutter app:

```bash
flutter create findback_mobile
cd findback_mobile
```

Replace `pubspec.yaml` and `lib/main.dart` with the files in `flutter/`.

Then:

```bash
flutter pub get
flutter run
```

### API URL

In `lib/main.dart`, change:

```dart
static const String baseUrl = 'http://10.0.2.2:8000/api';
```

- Android emulator -> `10.0.2.2`
- iOS simulator -> `http://127.0.0.1:8000/api`
- Physical phone -> use your computer's LAN IP, for example `http://192.168.1.10:8000/api`

For a physical phone, make sure the phone and computer are on the same Wi-Fi network and start Laravel so it is reachable on your LAN.

## IMPORTANT

The supplied image's left screen is visually a sign-in screen, while your instruction says it should be the register page. This version follows your written instruction and uses the left-screen design as a REGISTER page. If your research requires LOGIN instead, the backend already includes the mobile login endpoint and the fields can be switched easily.

The prototype intentionally has only two UI pages.
