import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/background_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 18,
            children: [
              Column(
                spacing: 8,
                children: [
                  Center(
                    child: textWidget(
                      value: "Welcome Back",
                      fsize: 24,
                      fweight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: textWidget(value: "Login to access your account"),
                  ),
                ],
              ),
              textWidget(value: "Email Address"),
              loginTextField("Enter your email", controller: _emailController),
              textWidget(value: "Phone Number"),
              loginTextField(
                "Enter your phone number",
                controller: _phoneController,
              ),
              textWidget(value: "Password"),
              loginTextField(
                "Enter your password",
                controller: _passwordController,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: textWidget(value: "Forgot Password?"),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(),
                  textWidget(value: "Or Sign In With"),
                  Divider(),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.home),
                      onPressed: () {},
                      label: Text("Google"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(value: "Don't have an account?"),
                  textWidget(value: "Sign Up"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text textWidget({
    required String value,
    double fsize = 12,
    FontWeight fweight = FontWeight.normal,
  }) {
    return Text(value, style: TextStyle(fontSize: fsize, fontWeight: fweight));
  }

  TextField loginTextField(
    String hinttext, {
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {});
      },
      obscuringCharacter: "*",
      obscureText: isPassword,
      style: TextStyle(),
      decoration: InputDecoration(
        hintText: hinttext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        suffixIcon: isPassword ? Icon(Icons.visibility) : null,
      ),
    );
  }
}
