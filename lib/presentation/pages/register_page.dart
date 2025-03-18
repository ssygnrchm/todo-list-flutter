// lib/presentation/pages/register_page.dart
import 'package:flutter/material.dart';
import 'package:my_first_app/domain/services/firebase_auth_service.dart';
import 'package:my_first_app/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Form Key
  final _formKey = GlobalKey<FormState>();
  // Activate Button
  bool _isActive = false;
  // Password visibility
  bool _isObsecure = true;
  bool _isConfirmObsecure = true;
  // Loading state
  bool _isLoading = false;
  // Error message
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Sign Up"), centerTitle: true),
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
                      value: "Create Account",
                      fsize: 24,
                      fweight: FontWeight.bold,
                      textColor: const Color.fromARGB(255, 34, 34, 34),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: textWidget(
                      value: "Sign up to get started",
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
                  const SizedBox(height: 18),
                  textWidget(value: "Phone Number"),
                  loginTextField(
                    "Enter your phone number",
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number is required";
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
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  textWidget(value: "Confirm Password"),
                  TextFormField(
                    controller: _confirmPasswordController,
                    onChanged: (value) {
                      setState(() {
                        _isActive = true;
                      });
                    },
                    obscuringCharacter: "•",
                    obscureText: _isConfirmObsecure,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      isDense: true,
                      hintText: "Confirm your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isConfirmObsecure = !_isConfirmObsecure;
                          });
                        },
                        icon: Icon(
                          _isConfirmObsecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != _passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                const SizedBox(height: 10),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isActive && !_isLoading ? _register : null,
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
                              : const Text("Register"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(value: "Already have an account?"),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: textWidget(
                      value: "Sign In",
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

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final user = await _authService.registerWithEmailAndPassword(
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
                    (context) => MyHome(
                      email: _emailController.text,
                      phone: _phoneController.text,
                    ),
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
