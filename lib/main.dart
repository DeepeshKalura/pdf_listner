import 'package:flutter/material.dart';
import 'package:pdf_listner/screens/authentication_screen.dart';
import 'package:pdf_listner/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2)))),
      initialRoute: AuthenticationScreen.routeName,
      routes: {
        AuthenticationScreen.routeName: (context) =>
            const AuthenticationScreen(),
      },
    );
  }
}
