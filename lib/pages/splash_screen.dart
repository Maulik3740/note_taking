// lib/pages/splash_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  Future<void> _startUp() async {
    try {
      // Run both: a minimal splash delay (2–3s) AND wait for first auth state.
      final results = await Future.wait([
        Future.delayed(const Duration(seconds: 4)),
        FirebaseAuth.instance
            .authStateChanges()
            .first, // 👈 ensures initial auth check completes
      ]);

      // The second result is the current user (or null)
      final User? user = results[1] as User?;

      if (!mounted || _navigated) return;
      _navigated = true;

      // Decide route based on auth
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // If anything fails, fail safe to Login
      if (!mounted || _navigated) return;
      _navigated = true;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/splash.json',
          width: 220,
          height: 220,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
