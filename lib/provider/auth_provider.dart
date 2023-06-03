import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin => _isLogin;
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
}
