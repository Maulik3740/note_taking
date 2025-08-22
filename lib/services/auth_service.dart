import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = true;

  User? get user => _user;
  bool get isLoading => _isLoading;

  AuthService() {
    _bindAuthState();
  }

  void _bindAuthState() {
    _auth.authStateChanges().listen((u) {
      _user = u;
      _isLoading = false;
      notifyListeners();
    });
  }

  /// Sign in → returns error message if failed, null if success
  Future<String?> signIn(String email, String password) async {
    return _handleAuth(() async {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    });
  }

  /// Sign up → returns error message if failed, null if success
  Future<String?> signUp(String email, String password) async {
    return _handleAuth(() async {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    });
  }

  /// Common handler for both sign in & sign up
  Future<String?> _handleAuth(Future<void> Function() action) async {
    _isLoading = true;
    notifyListeners();

    try {
      await action();
      _isLoading = false;
      notifyListeners();
      return null; // success
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.message ?? 'Authentication failed';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
