import 'package:flutter/material.dart';
import 'package:pdf_listner/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Consumer<AuthProvider>(builder: (context, provider, child) {
          return provider.isLoadingLogout
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: () {
                    provider.logOut(context);
                  },
                  icon: const Icon(Icons.logout_rounded));
        })
      ]),
      body: Center(child: Text("Doc App")),
    );
  }
}
