import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const blue = Color(0xFF2864E9);
const bg = Color(0xFFF8FAFC);

void main() => runApp(const FindBackApp());

class FindBackApp extends StatelessWidget {
  const FindBackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIND-BACK',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Arial',
      ),
      home: const RegisterPage(),
    );
  }
}

class ApiService {
  // Android emulator: 10.0.2.2
  // iOS simulator: 127.0.0.1
  // Physical phone: your computer's LAN IP
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Accept': 'application/json'},
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );

    final body = jsonDecode(response.body);
    if (response.statusCode >= 400) {
      throw Exception(body['message'] ?? 'Registration failed.');
    }
    return body;
  }

  static Future<Map<String, dynamic>> dashboard(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode >= 400) {
      throw Exception('Could not load dashboard.');
    }
    return jsonDecode(response.body);
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  bool loading = false;

  Future<void> submit() async {
    if (name.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        password.text.isEmpty ||
        password.text != confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form correctly.')),
      );
      return;
    }

    setState(() => loading = true);
    try {
      final data = await ApiService.register(
        name: name.text.trim(),
        email: email.text.trim(),
        password: password.text,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(
            token: data['token'],
            user: data['user'],
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 45, 22, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _Logo()),
              const SizedBox(height: 12),
              const Center(
                child: Text('FINDBACK',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
              ),
              const Center(
                child: Text('CAMPUS LOST & FOUND',
                    style: TextStyle(fontSize: 8, color: blue, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Text('Create your account',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text(
                'Register with your university credentials to report or find misplaced items.',
                style: TextStyle(fontSize: 10, color: Color(0xFF7A8495), height: 1.4),
              ),
              const SizedBox(height: 14),
              _Field(label: 'Full Name', controller: name, icon: Icons.person_outline, hint: 'Alex Mercer'),
              _Field(label: 'University Email', controller: email, icon: Icons.mail_outline, hint: 'alex.mercer@university.edu'),
              _Field(label: 'Password', controller: password, icon: Icons.lock_outline, hint: 'Minimum 8 characters', obscure: true),
              _Field(label: 'Confirm Password', controller: confirm, icon: Icons.lock_outline, hint: 'Repeat password', obscure: true),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: FilledButton(
                  onPressed: loading ? null : submit,
                  child: loading
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Create Account', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(height: 18),
              const Center(
                child: Text('FIND-BACK • Campus Lost & Found Research Prototype',
                    style: TextStyle(fontSize: 8, color: Color(0xFF8B95A4))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final String token;
  final Map<String, dynamic> user;

  const DashboardPage({super.key, required this.token, required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user['name'] ?? 'Student';
    final items = const [
      ['AirPods Pro (2nd Gen)', 'Science Library - Hallway', 'Posted 10m ago', Icons.headphones],
      ['Hydro Flask Bottle', 'Student Union Gym', 'Posted 2 hours ago', Icons.local_drink],
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 70),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome back,', style: TextStyle(fontSize: 9, color: Color(0xFF8892A1))),
                        Text('$name 👋', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_outline, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 9,
                crossAxisSpacing: 9,
                childAspectRatio: 1.5,
                children: const [
                  _ActionCard(Icons.search, 'Search Lost', 'Find misplaced assets'),
                  _ActionCard(Icons.description_outlined, 'Report Item', 'Post a missing item'),
                  _ActionCard(Icons.inventory_2_outlined, 'Found Items', 'Browse recovered items'),
                  _ActionCard(Icons.check_box_outlined, 'My Reports', 'Track your requests'),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Items', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  Text('View All', style: TextStyle(fontSize: 8, color: blue)),
                ],
              ),
              const SizedBox(height: 8),
              ...items.map((item) => _ItemCard(
                    icon: item[3] as IconData,
                    name: item[0] as String,
                    location: item[1] as String,
                    time: item[2] as String,
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFEDF4FF),
        ),
        child: const Icon(Icons.find_in_page_outlined, color: blue),
      );
}

class _Field extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final IconData icon;
  final bool obscure;

  const _Field({
    required this.label,
    required this.controller,
    required this.icon,
    required this.hint,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                prefixIcon: Icon(icon, size: 15, color: const Color(0xFF8290A5)),
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 10, color: Color(0xFF9AA3B1)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Color(0xFFE0E6EF)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Color(0xFFE0E6EF)),
                ),
              ),
            ),
          ],
        ),
      );
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const _ActionCard(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: const Color(0xFFE5EAF2)),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFFEDF4FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.search, color: blue, size: 14),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 7, color: Color(0xFF8993A2))),
                ],
              ),
            ),
          ],
        ),
      );
}

class _ItemCard extends StatelessWidget {
  final IconData icon;
  final String name, location, time;
  const _ItemCard({required this.icon, required this.name, required this.location, required this.time});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: const Color(0xFFE4E9F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF1F4),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(icon, color: const Color(0xFF677386)),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text('● $location', style: const TextStyle(fontSize: 7, color: Color(0xFF8A94A3))),
                  const SizedBox(height: 2),
                  Text('◷ $time', style: const TextStyle(fontSize: 7, color: Color(0xFF8A94A3))),
                ],
              ),
            ),
          ],
        ),
      );
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: blue,
        unselectedItemColor: const Color(0xFF697487),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 7,
        unselectedFontSize: 7,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 17), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 17), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 17), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.history, size: 17), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 17), label: 'Profile'),
        ],
      );
}
