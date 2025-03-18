// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:my_first_app/domain/services/firebase_auth_service.dart';
import 'package:my_first_app/main.dart';
import 'package:my_first_app/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Form Key
  final _formKey = GlobalKey<FormState>();
  // Activate Button
  bool _isActive = false;
  // Password visibility
  bool _isObsecure = true;
  // Loading state
  bool _isLoading = false;

  // Error message
  String? _errorMessage;

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
            image: AssetImage("assets/images/background_login.png"),
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
                        return "Email is required";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 18),
                  // textWidget(value: "Phone Number"),
                  // loginTextField(
                  //   "Enter your phone number",
                  //   controller: _phoneController,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Phone number is required";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 18),
                  textWidget(value: "Password"),
                  loginTextField(
                    "Enter your password",
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => _forgotPassword(),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: textWidget(
                        value: "Forgot Password?",
                        textColor: const Color.fromARGB(255, 243, 75, 27),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Display error message if any
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isActive && !_isLoading ? _login : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height / 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor:
                            _isActive && !_isLoading
                                ? const Color.fromARGB(255, 40, 63, 177)
                                : const Color.fromARGB(255, 153, 157, 177),
                        foregroundColor: Colors.white,
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text("Login"),
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
                        "assets/images/iconGoogle.png",
                        height: 24,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height / 15,
                        ),
                      ),
                      onPressed: () {
                        // Google sign-in would go here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Google sign-in not implemented yet'),
                          ),
                        );
                      },
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: textWidget(
                      value: "Sign Up",
                      textColor: const Color.fromARGB(255, 40, 63, 177),
                      fweight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final user = await _authService.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        if (user != null) {
          // Navigate to home screen
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        MyHome(email: _emailController.text, phone: ''),
              ),
            );
          }
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _forgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _errorMessage = "Please enter your email to reset password";
      });
      return;
    }

    try {
      await _authService.sendPasswordResetEmail(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent to $email')),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
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
