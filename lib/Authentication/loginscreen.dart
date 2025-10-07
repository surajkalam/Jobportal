import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Authentication/Signupscreen.dart';
import 'package:jobapp/Authentication/otpscreen.dart';
import 'package:jobapp/Authentication/provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String option;

  const LoginScreen({super.key, required this.option});

  @override
  ConsumerState<LoginScreen> createState() => _LoginpageState();
}

class _LoginpageState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrMobileController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _navigateToSignup() {
    final userType = ref.read(selectionProvider);
    final option = userType == UserType.jobseeker ? 'jobseeker' : 'recruiter';
    context.goNamed('signup', extra: option);
  }

  void _navigateToOtp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Otpscreen()),
      );
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    log("✅ Login successful for: ${_emailOrMobileController.text}");

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _isLoading = false;
    });
    _navigateToOtp();
  }

  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(selectionProvider);

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
              // Header with user type
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        userType.name.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.03,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
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

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email/Mobile Field
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
                          fillColor: const Color.fromRGBO(223, 226, 230, 1),
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

                          if (value.contains("@")) {
                            final emailRegex = RegExp(
                              r'^[\w\.-]+@[\w\.-]+\.\w+$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                          } else {
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

                    // Password Field
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
                          fillColor: const Color.fromRGBO(223, 226, 230, 1),
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
                  ],
                ),
              ),

              // Sign up link
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
                          ..onTap = _navigateToSignup,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),

              // Login Button
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: width * 0.03),
                      backgroundColor: _isLoading
                          ? Colors.grey
                          : colorScheme.secondaryFixed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? SizedBox(
                            height: width * 0.04,
                            width: width * 0.04,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : Text(
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
