import 'package:flutter/material.dart';
import '../utils/snack.dart';

String? validateEmail(String? value) {
  if (value == null || !value.contains('@')) {
    return 'Enter a valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.length < 6) {
    return 'Min 6 characters';
  }
  return null;
}

Future<void> handleAuthSubmit({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController email,
  required TextEditingController password,
  required Future<String?> Function(String email, String password) authFn,
}) async {
  if (!formKey.currentState!.validate()) return;

  final error = await authFn(email.text.trim(), password.text.trim());

  if (!context.mounted) return;

  if (error != null) {
    showSnack(context, error);
  } else {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
