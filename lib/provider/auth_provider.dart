import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/snackbar_helper.dart';
import 'package:pdf_listner/screens/authentication_screen.dart';
import 'package:pdf_listner/screens/forgot_password_screen.dart';
import 'package:pdf_listner/screens/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin => _isLogin;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


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
  setIsLoading(bool value) {
    _isLoaded = value;
    notifyListeners();
  }

  signUp(BuildContext context,
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setIsLoading(false);
        SnackBarHelper.showSucessSnackBar(context, "SignUp Successful");
        Navigator.of(context).pushNamed(AuthenticationScreen.routeName);
        _isLogin = true;
        notifyListeners();

        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setIsLoading(false);
        SnackBarHelper.showSucessSnackBar(context, "SignIn Successful");
        Navigator.of(context).pushNamed(HomeScreen.routeName);

        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  bool _isForgetPassword = false;
  bool get isForgetPassword => _isForgetPassword;
  setIsForgetPassword(bool value) {
    _isForgetPassword = value;
    notifyListeners();
  }

  forgetPassword({required BuildContext context, required String email}) async {
    try {
      setIsForgetPassword(true);
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        setIsForgetPassword(false);

        SnackBarHelper.showSucessSnackBar(context, "Reset Email send!");
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsForgetPassword(false);

      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsForgetPassword(false);

      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  bool _isLoadingLogout = false;
  bool get isLoadingLogout => _isLoadingLogout;
  setLogout(bool value) {
    _isLoadingLogout = value;
    notifyListeners();
  }

  logOut(BuildContext context) async {
    try {
      setLogout(false);
      await _firebaseAuth.signOut().then((value) {
        setLogout(false);
        SnackBarHelper.showSucessSnackBar(context, "successfully log out");
        Navigator.of(context).pushNamed(AuthenticationScreen.routeName);
      });
    } on FirebaseAuthException catch (firebaseError) {
      setLogout(false);

      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setLogout(false);

      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
    
  }


}
