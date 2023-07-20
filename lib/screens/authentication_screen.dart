import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/provider/auth_provider.dart';
import 'package:pdf_listner/screens/forgot_password_screen.dart';
import 'package:pdf_listner/widgets/custom_button.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';
import 'package:pdf_listner/widgets/screen_background.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = "/authenticationScreen";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userNameController =
      TextEditingController(); // bhai inno na ap private bana
  TextEditingController emailController =
      TextEditingController(text: "arpit@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "12345678");
  TextEditingController confirmPasswordController = TextEditingController();

//   Dispose Bhi ker dena sare controller ko

  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: ScreenBackground(
            child: Form(
              key: _key,
              child: ListView(children: [
                Image.asset(
                  "assets/images/icon_image.png",
                  height: 150,
                ),
                SizedBoxHelper.sizedBox20,
                if (!provider.isLogin)
                  CustomTextField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "please enter a username";
                        } else {
                          return null;
                        }
                      },
                      controller: userNameController,
                      hintText: "Enter Your Username",
                      labelText: "Username",
                      prefixIconData: Icons.person),
                SizedBoxHelper.sizedBox20,
                CustomTextField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "please enter a Email";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    hintText: "Enter Your Email",
                    labelText: "Email",
                    prefixIconData: Icons.email),
                SizedBoxHelper.sizedBox20,
                CustomTextField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "please enter a username";
                    } else if (value.length < 8) {
                      return "password should be of atleat 8 characters";
                    } else {
                      return null;
                    }
                  },
                  obscureText: provider.obscureText,
                  controller: passwordController,
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  prefixIconData: Icons.password,
                  suffixIcon: IconButton(
                      onPressed: () {
                        provider.setObscureText();
                      },
                      icon: Icon(
                        provider.obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                      )),
                ),
                SizedBoxHelper.sizedBox20,
                if (!provider.isLogin)
                  CustomTextField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "please enter a value";
                      } else if (value != passwordController.text) {
                        return "both password does not match";
                      } else {
                        return null;
                      }
                    },
                    obscureText: provider.obscureText,
                    controller: confirmPasswordController,
                    hintText: "Enter the password again",
                    labelText: "Confirm Password",
                    prefixIconData: Icons.password,
                    suffixIcon: Icon(
                      provider.obscureText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                    ),
                  ),
                SizedBoxHelper.sizedBox20,
                (provider.isLoaded)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            if (provider.isLogin) {
                              provider.signIn(context,
                                  email: emailController.text,
                                  password: passwordController.text);
                            } else {
                              provider.signUp(context,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }
                        },
                        title: provider.isLogin ? "login" : "Register",
                      ),
                MaterialButton(
                  onPressed: () {
                    provider.setIsLogin();
                  },
                  child: Text(provider.isLogin
                      ? "Dont have accont register"
                      : "Already have an account? Login"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ForgotPasswordScreen.routeName);
                  },
                  child: Text("Forget Password?"),
                )
              ]),
            ),
          ),
        );
      }),
    );
  }
}
