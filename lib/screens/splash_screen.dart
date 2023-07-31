import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf_listner/screens/authentication_screen.dart';
import 'package:pdf_listner/screens/home_screen.dart';
import 'package:pdf_listner/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigate() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      bool value = FirebaseAuth.instance.currentUser == null;
      if (value) {
        Navigator.of(context)
            .pushReplacementNamed(AuthenticationScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    _navigate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Center(child: Image.asset("assets/images/icon_image.png"))),
    );
  }
}
