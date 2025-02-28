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

  // To check if textfield is for password
  bool isPassword = false;

  // Icon for password visibility
  Icon visibilityIcon = Icon(Icons.visibility_off_outlined);

  // Password visibility
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/background_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      textColor: const Color.fromARGB(255, 34, 34, 34),
                    ),
                  ),
                  Center(
                    child: textWidget(
                      value: "Login to access your account",
                      fsize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18,
                children: [
                  textWidget(value: "Email Address"),
                  loginTextField(
                    "Enter your email",
                    controller: _emailController,
                  ),
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
                    child: textWidget(
                      value: "Forgot Password?",
                      textColor: const Color.fromARGB(255, 243, 75, 27),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // MyHome();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          MediaQuery.sizeOf(context).height / 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color.fromARGB(255, 40, 63, 177),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Login"),
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
                      icon: Image.asset("asset/iconGoogle.png"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          MediaQuery.sizeOf(context).height / 15,
                        ),
                      ),
                      onPressed: () {},
                      label: Text("Google"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  textWidget(value: "Don't have an account?"),
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
      obscuringCharacter: "•",
      obscureText: isPassword ? isObsecure : false,
      style: TextStyle(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        isDense: true,
        hintText: hinttext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObsecure = !isObsecure;
                    });
                  },
                  icon: Icon(
                    isObsecure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                    size: 24,
                  ),
                )
                : null,
      ),
    );
  }
}
