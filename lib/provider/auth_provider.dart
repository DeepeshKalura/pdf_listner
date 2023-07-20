import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';
import 'package:pdf_listner/screens/forgot_password_screen.dart';

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
  signUp(BuildContext context,
      {required String email, required String password}) async {
    try {
      _isLoaded = true;
      notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _isLoaded = false;
        notifyListeners();
        SnackBarHelper.showSucessSnackBar(context, "SignUp Successful");
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      _isLoaded = false;
      notifyListeners();
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      _isLoaded = false;
      notifyListeners();
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      _isLoaded = true;
      notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _isLoaded = false;
        notifyListeners();
        SnackBarHelper.showSucessSnackBar(context, "SignIn Successful");
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      _isLoaded = false;
      notifyListeners();
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      _isLoaded = false;
      notifyListeners();
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  bool _isForgetPassword = false;
  bool get isForgetPassword => _isForgetPassword;

  forgetPassword({required BuildContext context, required String email}) async {
    try {
      _isForgetPassword = true;
      notifyListeners();
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        _isForgetPassword = false;
        notifyListeners();
        SnackBarHelper.showSucessSnackBar(context, "Reset Email send!");
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      _isForgetPassword = false;
      notifyListeners();
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      _isForgetPassword = false;
      notifyListeners();
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }
}
