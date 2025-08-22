// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_taking/pages/login_page.dart';
import 'package:note_taking/pages/notes_page.dart';
import 'package:note_taking/pages/sign_up_page.dart';
import 'package:note_taking/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        title: 'Notes Taking',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
          '/sign-up': (_) => const SignUpPage(),
          '/home': (_) => const NotesPage(),
        },
      ),
    );
  }
}
