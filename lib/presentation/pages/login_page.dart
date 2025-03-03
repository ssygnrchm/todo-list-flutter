// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:my_first_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form Key
  final _formKey = GlobalKey<FormState>();
  // Activate Button
  bool _isActive = false;
  // Password visibility
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/images/background_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Center(
                    child: textWidget(
                      value: "Welcome Back",
                      fsize: 24,
                      fweight: FontWeight.bold,
                      textColor: const Color.fromARGB(255, 34, 34, 34),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: textWidget(
                      value: "Login to access your account",
                      fsize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(value: "Email Address"),
                  loginTextField(
                    "Enter your email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email belum diisi";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  textWidget(value: "Phone Number"),
                  loginTextField(
                    "Enter your phone number",
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nomor telepon belum diisi";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  textWidget(value: "Password"),
                  loginTextField(
                    "Enter your password",
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password belum diisi";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: textWidget(
                      value: "Forgot Password?",
                      textColor: const Color.fromARGB(255, 243, 75, 27),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _isActive
                              ? () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => MyHome(
                                            email: _emailController.text,
                                            phone: _phoneController.text,
                                          ),
                                    ),
                                  );
                                }
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height / 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor:
                            _isActive
                                ? const Color.fromARGB(255, 40, 63, 177)
                                : const Color.fromARGB(255, 153, 157, 177),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: textWidget(value: "Or Sign In With"),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Image.asset(
                        "asset/images/iconGoogle.png",
                        height: 24,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height / 15,
                        ),
                      ),
                      onPressed: () {},
                      label: const Text("Google"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(value: "Don't have an account?"),
                  const SizedBox(width: 4),
                  textWidget(
                    value: "Sign Up",
                    textColor: const Color.fromARGB(255, 40, 63, 177),
                    fweight: FontWeight.bold,
                  ),
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
    Color textColor = const Color.fromARGB(255, 136, 136, 136),
  }) {
    return Text(
      value,
      style: TextStyle(fontSize: fsize, fontWeight: fweight, color: textColor),
    );
  }

  Widget loginTextField(
    String? hinttext, {
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        setState(() {
          _isActive = true;
        });
      },
      obscuringCharacter: "•",
      obscureText: isPassword ? _isObsecure : false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        isDense: true,
        hintText: hinttext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObsecure = !_isObsecure;
                    });
                  },
                  icon: Icon(
                    _isObsecure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                    size: 24,
                  ),
                )
                : null,
      ),
      validator: validator,
    );
  }
}
