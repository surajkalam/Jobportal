// import 'dart:developer';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:jobapp/Authentication/otpscreen.dart';
// import 'package:jobapp/Authentication/provider.dart';
// import 'package:jobapp/core/util/appcolors.dart';

// class LoginScreen extends ConsumerStatefulWidget {
//   final String option;

//   const LoginScreen({super.key, required this.option});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginpageState();
// }

// class _LoginpageState extends ConsumerState<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailOrMobileController =
//       TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;

//   void _navigateToSignup() {
//     final userType = ref.read(selectionProvider);
//     final option = userType == UserType.jobseeker ? 'jobseeker' : 'recruiter';
//     context.goNamed('signup', extra: option);
//   }

//   // void _navigateToOtp() {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => const Otpscreen()),
//   //     );
//   //   });
//   // }
// void _navigateBasedOnUserType() {
//     final userType = ref.read(selectionProvider);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (userType == UserType.jobseeker) {
//         context.go('/job-nav');
//       } else {
//         context.go('/recuiter-nav');
//       }
//     });
//   }
//   Future<void> _handleLogin() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     setState(() {
//       _isLoading = true;
//     });

//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 2));
//     log("✅ Login successful for: ${_emailOrMobileController.text}");
//     _showSnackBar(
//       // ignore: use_build_context_synchronously
//       context: context,
//       text: 'Login successful! 👍',
//       textColor: Colors.green.shade800,
//     );
//     setState(() {
//       _isLoading = false;
//     });
//     _navigateBasedOnUserType();
//     // _navigateToOtp();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userType = ref.watch(selectionProvider);

//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(width * 0.02),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: height * 0.01),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.04,
//                         vertical: height * 0.005,
//                       ),
//                       decoration: BoxDecoration(
//                         // ignore: deprecated_member_use
//                         color: colorScheme.primary.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         userType.name.toUpperCase(),
//                         style: GoogleFonts.poppins(
//                           fontSize: width * 0.03,
//                           color: colorScheme.primary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Image.asset(
//                 "asset/images/login.png",
//                 height: height * 0.3,
//                 width: width * 0.5,
//                 fit: BoxFit.fill,
//               ),
//               SizedBox(height: height * 0.02),
//               Text(
//                 " 👇 Login to continue your job search",
//                 style: textTheme.bodySmall,
//               ),
//             SizedBox(height: 20),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.03,
//                         vertical: height * 0.008,
//                       ),
//                       child: TextFormField(
//                         controller: _emailOrMobileController,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           labelText: "Enter email",
//                           labelStyle:   textTheme.bodySmall?.copyWith(
//                             fontSize: 11,
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.8),
//                           ),
//                           hintText: ' Email..',
//                           hintStyle:textTheme.bodySmall?.copyWith(
//                             fontSize: 12,
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.6),
//                           ),
//                           filled: true,
//                           fillColor: AppColors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.8),
//                             ),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.person,
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.7),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please enter email or mobile number";
//                           }
//                           value = value.trim();
//                           if (value.contains("@")) {
//                             final emailRegex = RegExp(
//                               r'^[\w\.-]+@[\w\.-]+\.\w+$',
//                             );
//                             if (!emailRegex.hasMatch(value)) {
//                               return "Enter a valid email address";
//                             }
//                           } else {
//                             final mobileRegex = RegExp(r'^[0-9]{10}$');
//                             if (!mobileRegex.hasMatch(value)) {
//                               return "Enter a valid 10-digit mobile number";
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Password Field
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.03,
//                         vertical: height * 0.01,
//                       ),
//                       child: TextFormField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           labelText: "Password",
//                           labelStyle:   textTheme.bodySmall?.copyWith(
//                             fontSize: 11,
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.8),
//                           ),
//                           hintText: 'Password',
//                           hintStyle:textTheme.bodySmall?.copyWith(
//                             fontSize: 12,
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.6),
//                           ),
//                           filled: true,
//                           fillColor: AppColors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.8),
//                             ),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.lock,
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.7),
//                           ),
//                           suffixIcon: IconButton(
//                             // ignore: deprecated_member_use
//                             color: AppColors.grey.withOpacity(0.7),
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter a password";
//                           } else if (value.length < 6) {
//                             return "Password must be at least 6 characters";
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     // Forgot Password Text
//                     Padding(
//                       padding: EdgeInsets.only(top: height * 0.01, right: width * 0.03),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             // Add forgot password functionality here
//                             log("Forgot password tapped");
//                           },
//                           child: Text(
//                             "Forgot Password?",
//                             style: GoogleFonts.poppins(
//                               fontSize: width * 0.035,
//                               // ignore: deprecated_member_use
//                               color: AppColors.grey.withOpacity(0.8),
//                               fontWeight: FontWeight.w500,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Sign up link
//               Padding(
//                 padding: EdgeInsets.only(bottom: 10, top: 20),
//                 child: RichText(
//                   text: TextSpan(
//                     style: GoogleFonts.poppins(
//                       fontSize: width * 0.035,
//                       color: colorScheme.primary,
//                     ),
//                     children: [
//                     TextSpan(text: "You haven't account? "),
//                       TextSpan(
//                         text: "Sign up",
//                         style: GoogleFonts.poppins(
//                           color: colorScheme.secondaryFixed,
//                           fontWeight: FontWeight.w600,
//                           decoration: TextDecoration.underline,
//                         ),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = _navigateToSignup,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: height * 0.04),
//               // Login Button
//               Padding(
//                 padding: EdgeInsets.only(bottom: 10),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: width * 0.03),
//                       backgroundColor: _isLoading
//                           ? Colors.grey
//                           : colorScheme.secondaryFixed,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _handleLogin,
//                     child: _isLoading
//                         ? SizedBox(
//                             height: width * 0.04,
//                             width: width * 0.04,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 colorScheme.onPrimary,
//                               ),
//                             ),
//                           )
//                         : Text(
//                             "Continue",
//                             style: GoogleFonts.poppins(
//                               fontSize: width * 0.04,
//                               color: colorScheme.onPrimary,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _showSnackBar({
//     required BuildContext context,
//     required String text,
//     Color backgroundColor = Colors.white,
//     Color textColor = Colors.green,
//     Duration duration = const Duration(seconds: 3),
//     SnackBarBehavior behavior = SnackBarBehavior.floating,
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(text, 
//         style: TextStyle(
//           color: textColor,
//           fontSize: 10,
//         fontWeight: FontWeight.w500),
//         textAlign: TextAlign.center,
//         ),
//         backgroundColor: backgroundColor,
//         duration: duration,
//         behavior: behavior,
//         margin: EdgeInsets.all(12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: textColor),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Authentication/provider.dart';
import 'package:jobapp/Authentication/auth_state.dart';
import 'package:jobapp/Authentication/user_provider.dart';
import 'package:jobapp/core/util/appcolors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String option;

  const LoginScreen({super.key, required this.option});

  @override
  ConsumerState<LoginScreen> createState() => _LoginpageState();
}

class _LoginpageState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Clear any previous errors when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authStateProvider.notifier).clearError();
    });
  }

  void _navigateToSignup() {
    final userType = ref.read(selectionProvider);
    final option = userType == UserType.jobseeker ? 'jobseeker' : 'recruiter';
    context.goNamed('signup', extra: option);
  }

  void _navigateBasedOnUserType(String userEmail) {
    final userType = ref.read(selectionProvider);

    // Store email in appropriate provider based on user type
    if (userType == UserType.jobseeker) {
      ref.read(currentUserProvider.notifier).state = userEmail;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/jobseeker-info');
      });
    } else {
      ref.read(currentRecruiterUserEmailProvider.notifier).state = userEmail;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/recuiter-info');
      });
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authStateProvider.notifier);
    
    final user = await authNotifier.loginWithEmailAndPassword(
      email: _emailOrMobileController.text.trim(),
      password: _passwordController.text,
    );

    if (user != null) {
      final userEmail = user.email ?? _emailOrMobileController.text.trim();
      
      _showSnackBar(
        context: context,
        text: 'Login successful! 👍',
        textColor: Colors.green.shade800,
      );
      
      log("✅ Login successful for: $userEmail");
      
      // Navigate based on user type
      _navigateBasedOnUserType(userEmail);
    } else {
      // Error is already handled in the auth state
      final error = ref.read(authStateProvider).error;
      if (error != null) {
        _showSnackBar(
          context: context,
          text: error,
          textColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(selectionProvider);
    final authState = ref.watch(authStateProvider);

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
                " 👇 Login to continue your job search",
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.008,
                      ),
                      child: TextFormField(
                        controller: _emailOrMobileController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Enter email",
                          labelStyle: textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: AppColors.grey.withOpacity(0.8),
                          ),
                          hintText: 'Email..',
                          hintStyle: textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: AppColors.grey.withOpacity(0.6),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.5),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.8),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.grey.withOpacity(0.7),
                          ),
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
                          labelStyle: textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: AppColors.grey.withOpacity(0.8),
                          ),
                          hintText: 'Password',
                          hintStyle: textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: AppColors.grey.withOpacity(0.6),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.5),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.grey.withOpacity(0.8),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.grey.withOpacity(0.7),
                          ),
                          suffixIcon: IconButton(
                            color: AppColors.grey.withOpacity(0.7),
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
                    // Forgot Password Text
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.01, right: width * 0.03),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Add forgot password functionality here
                            log("Forgot password tapped");
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.035,
                              color: AppColors.grey.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
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
                      backgroundColor: authState.isLoading
                          ? Colors.grey
                          : colorScheme.secondaryFixed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: authState.isLoading ? null : _handleLogin,
                    child: authState.isLoading
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
        content: Text(
          text, 
          style: TextStyle(
            color: textColor,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: textColor),
        ),
      ),
    );
  }
}