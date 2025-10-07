import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Authentication/provider.dart';

class CheckLoginSignupScreen extends ConsumerStatefulWidget {
  const CheckLoginSignupScreen({super.key});

  @override
  ConsumerState<CheckLoginSignupScreen> createState() => _CheckLoginSignupScreenState();
}

class _CheckLoginSignupScreenState extends ConsumerState<CheckLoginSignupScreen> {
  int _selectedIndex = 0;

  void _navigateToLogin() {
    final userType = ref.read(selectionProvider);
    final option = userType == UserType.jobseeker ? 'jobseeker' : 'recruiter';
    
    context.goNamed('login', extra: option);
  }

  void _navigateToSignup() {
    final userType = ref.read(selectionProvider);
    final option = userType == UserType.jobseeker ? 'jobseeker' : 'recruiter';
    
    context.goNamed('signup', extra: option);
  }

  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(selectionProvider);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final colorScheme = Theme.of(context).colorScheme;

    // Light blue color for selection
    const Color lightBlue = Color(0xFFE3F2FD);
    const Color selectedBlue = Color(0xFF2196F3);
    const Color whiteColor = Colors.white;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: height * 0.1)),
          SizedBox(height: height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.045,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(width * 0.05),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(1, 2),
                    ),
                  ], 
                ),
                child: Row(
                  children: [
                    // Jobseeker Option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                        ref.read(selectionProvider.notifier).state = UserType.jobseeker;
                      },
                      child: Container(
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 0 ? selectedBlue : lightBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.05),
                            bottomLeft: Radius.circular(width * 0.05),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Jobseeker",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.04,
                              color: _selectedIndex == 0 ? whiteColor : selectedBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Recruiter Option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                        ref.read(selectionProvider.notifier).state = UserType.recruiter;
                      },
                      child: Container(
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 1 ? selectedBlue : lightBlue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * 0.05),
                            bottomRight: Radius.circular(width * 0.05),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Recruiter",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.04,
                              color: _selectedIndex == 1 ? whiteColor : selectedBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.06,
            ),
            child: Column(
              children: [
                // Login Button
                GestureDetector(
                  onTap: _navigateToLogin,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: selectedBlue,
                      borderRadius: BorderRadius.circular(width * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.04,
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                // SignUp Button
                GestureDetector(
                  onTap: _navigateToSignup,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: selectedBlue, width: 2),
                      borderRadius: BorderRadius.circular(width * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.04,
                          color: selectedBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.09),
                Text(
                  "your journey starts today.",
                  style: GoogleFonts.lora(
                    fontSize: width * 0.042,
                    color: selectedBlue,
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: true,
                ),
                Text(
                  "Fresh beginnings,Bright opportunities.",
                  style: GoogleFonts.lora(
                    fontSize: width * 0.042,
                    color: selectedBlue,
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}