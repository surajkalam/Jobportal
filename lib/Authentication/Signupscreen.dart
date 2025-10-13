
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Authentication/provider.dart';
import 'package:lottie/lottie.dart';
class SignupScreen extends ConsumerStatefulWidget {
  final String option;
  const SignupScreen({super.key, required this.option});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  void _navigateBasedOnUserType() {
    final userType = ref.read(selectionProvider);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userType == UserType.jobseeker) {
       context.go('/job-nav');
      } else {
      context.go('/recuiter-nav');
      }
    });
  }
  bool _validateForm() {
    // Check mobile number
    if (_phoneController.text.length != 10) {
      _showSnackBar(
        context: context,
        text: 'Please enter a valid 10-digit mobile number',
        textColor: Colors.red,
      );
      return false;
    }

    // Check password length
    if (_passwordController.text.length < 6) {
      _showSnackBar(
        context: context,
        text: 'Password must be at least 6 characters',
        textColor: Colors.red,
      );
      return false;
    }

    // Check password match
    if (_confirmPasswordController.text != _passwordController.text) {
      _showSnackBar(
        context: context,
        text: 'Passwords do not match!',
        textColor: Colors.red,
      );
      return false;
    }

    return true;
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      debugPrint(
        "✅ Signup successful with: ${_emailOrMobileController.text}",
      );
      _showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: '✅ Signup successful !👍 ',
        textColor: Colors.green,
      );

      // Navigate based on user type from provider
      _navigateBasedOnUserType();

    } catch (e) {
      _showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: 'Signup failed try again and fill all details',
        textColor: Colors.red,
       
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleGoogleSignup() {
    if (!_validateForm()) {
      return;
    }
    _showSnackBar(
      context: context,
      text: 'Google signup functionality',
    );
  }

  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(selectionProvider);
    
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Form(
            key: _formKey,
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
                
                const SizedBox(height: 20),
                
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email field
                TextFormField(
                  controller: _emailOrMobileController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    filled: true,
                    fillColor: const Color.fromRGBO(223, 226, 230, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter email";
                    }
                    
                    value = value.trim();
                    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),

                // Mobile number field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "Enter mobile number",
                    filled: true,
                    fillColor: const Color.fromRGBO(223, 226, 230, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter mobile number";
                    } else if (value.length != 10) {
                      return "Enter valid 10-digit number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password field
                TextFormField(
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
                
                SizedBox(height: height * 0.02),
                
                // Confirm Password field
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm password",
                    filled: true,
                    fillColor: const Color.fromRGBO(223, 226, 230, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    } else if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                // Google Signup Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.04,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      color: Colors.transparent,
                      border: Border.all(color: colorScheme.primary, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "asset/images/google.png",
                          height: height * 0.03,
                          width: height * 0.03,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: width * 0.03),
                        GestureDetector(
                          onTap: _handleGoogleSignup,
                          child: Text(
                            "Continue with Google",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.04,
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Signup Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: _isLoading 
                          ? Colors.grey 
                          : colorScheme.secondaryFixed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _isLoading ? null : _handleSignup,
                    child: _isLoading
                        ? SizedBox(
                            height: width * 0.04,
                            width: width * 0.04,
                            // child: CircularProgressIndicator(
                            //   strokeWidth: 2,
                            //   valueColor: AlwaysStoppedAnimation<Color>(
                            //     colorScheme.onPrimary,
                            //   ),
                            // ),
                            child: Lottie.asset('asset/icons/loading colour.json',
                            height: width * 0.01,
                            fit: BoxFit.cover
                            ),
                          )
                        : Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showSnackBar({
    required BuildContext context,
    required String text,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.green,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, 
        style: TextStyle(
          color: textColor,
          fontSize: 10,
        fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: textColor),
        ),
      ),
    );
  }
}
