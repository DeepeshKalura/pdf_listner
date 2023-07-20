import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin => _isLogin;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  setIsLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;
  setObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  signUp({required String email, required String password}) async {
    _isLoaded = true;
    notifyListeners();
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    _isLoaded = false;
    notifyListeners();
  }

  signIn({required String email, required String password}) async {
    _isLoaded = true;
    notifyListeners();
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    _isLoaded = false;
    notifyListeners();
  }
}
