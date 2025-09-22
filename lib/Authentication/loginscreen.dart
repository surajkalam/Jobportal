import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Authentication/Signupscreen.dart';
import 'package:jobapp/Authentication/otpscreen.dart';
import 'package:jobapp/core/material_theme.dart';

class LoginScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final option;
  // ignore: non_constant_identifier_names
  const LoginScreen({super.key, required this.option});

  @override
  State<LoginScreen> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailOrMobileController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.01, left: width * 0.9),
              ),
              Image.asset(
                "asset/images/login.png",
                height: height * 0.3,
                width: width * 0.5,
                fit: BoxFit.fill,
              ),
              SizedBox(height: height * 0.02),
              Text(
                " 👇 Enter your credential for login",
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.01,
                ),
                child: TextFormField(
                  controller: _emailOrMobileController,
                  keyboardType: TextInputType.text,

                  decoration: InputDecoration(
                    labelText: "Email or Mobile Number",
                    filled: true,
                    fillColor: Color.fromRGBO(223, 226, 230, 1),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter email or mobile number";
                    }

                    value = value.trim();

                    // if contains @ → email
                    if (value.contains("@")) {
                      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                    } else {
                      // mobile → digits only, length = 10
                      final mobileRegex = RegExp(r'^[0-9]{10}$');
                      if (!mobileRegex.hasMatch(value)) {
                        return "Enter a valid 10-digit mobile number";
                      }
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Password field
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.01,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Color.fromRGBO(223, 226, 230, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: width * 0.03,
              //     vertical: height * 0.025,
              //   ),
              //   child: Form(
              //     key: _formKey,
              //     child: Column(
              //       children: [
              //         TextFormField(
              //           controller: _mobileController,
              //           keyboardType: TextInputType.phone,
              //           maxLength: 10, // 🔹 Only allow 10 digits input
              //           decoration: InputDecoration(
              //             labelText: "Mobile Number",
              //             hintText: "Enter your mobile number",
              //             counterText: "", // hide maxLength counter
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             prefixIcon: const Icon(Icons.phone),
              //           ),
              //           validator: (value) {
              //             if (value == null || value.isEmpty) {
              //               return "Please enter mobile number";
              //             } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              //               return "Enter valid 10-digit number";
              //             }
              //             return null;
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.035,
                      color: colorScheme.primary,
                    ),
                    children: [
                      const TextSpan(text: "You haven't account? "),
                      TextSpan(
                        text: "Sign up",
                        style: GoogleFonts.poppins(
                          color: colorScheme.secondaryFixed,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SignupScreen(option: widget.option),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),
              // Submit Button
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: width * 0.03),
                      backgroundColor: colorScheme.secondaryFixed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_passwordController.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Password must be at least 6 characters',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        log(
                          "✅ Mobile Number Entered: ${_mobileController.text}",
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Mobile: ${_mobileController.text}"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Otpscreen()),
                      );
                    },
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.04,
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
