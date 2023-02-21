import 'dart:ffi';
import 'package:dev_connect/Model/LoginModel.dart';
import 'package:dev_connect/Screens/AuthenticationScreens/SignupScreen.dart';
import 'package:dev_connect/Screens/TabScreens/TabsScreen.dart';
import 'package:dev_connect/Services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _errorMessage = '';
  bool _validate = false;

  var _isLoggedIn = true;

  loginUser(String email, String password) async {
    var loginResponse = await LoginService().loginUser(email, password);

    if (loginResponse != Null) {
      print(loginResponse!.email);
      _isLoggedIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: !_isLoggedIn,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/devconnect-logo.png"),
                  height: 100,
                ),
                const Text("Dev Connect",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                const SizedBox(height: 30),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    validateEmail(val);
                  },
                  decoration: const InputDecoration(
                    // errorText: _validate ? null : _errorMessage,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        _isLoggedIn = false;
                      });
                      await loginUser(emailController.text.toString(),
                          passwordController.text.toString());
                      if (_isLoggedIn) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TabsScreen()));
                      } else {
                        print("Login Error");
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.black),
                      width: 220,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: const Text("Sign Up"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
        _validate = false;
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
        _validate = false;
      });
    } else {
      setState(() {
        _errorMessage = "";
        _validate = true;
      });
    }
  }
}
