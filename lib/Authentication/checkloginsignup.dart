import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Authentication/Signupscreen.dart';
import 'package:jobapp/Authentication/loginscreen.dart';
// import 'package:jobapp/core/material_theme.dart';

class CheckLoginSignupScreen extends StatefulWidget {
  const CheckLoginSignupScreen({super.key});

  @override
  State<CheckLoginSignupScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CheckLoginSignupScreen> {
  int _selectedIndex = 0;
  String selectedoption='jobseeker';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   height: height * 0.1,
          //   width: width,
          //   decoration: BoxDecoration(
          //     color: colorScheme.primary,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(width * 0.1),
          //       bottomRight: Radius.circular(width * 0.1),
          //     ),
          //   ),
          //   child: Center(
          //     child: Text(
          //       "Welcome to JobApp",
          //       style: GoogleFonts.poppins(
          //         fontSize: width * 0.06,
          //         color: colorScheme.onPrimary,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ),
          // ),
          Padding(padding:EdgeInsets.only(top: 90)),
          SizedBox(height: height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.045,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(width * 0.05),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: colorScheme.shadow.withAlpha(200),// shadow color
                      spreadRadius: 2, // how wide the shadow spreads
                      blurRadius: 6, // softness of the shadow
                      offset: const Offset(2, 3), // x,y position of shadow
                    ),
                  ], 
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      child: Container(
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 0
                              ? colorScheme.primaryFixed
                              : colorScheme.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.05),
                            bottomLeft: Radius.circular(width * 0.05),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Jobseeker",
                            // style: GoogleFonts.poppins(
                            //   fontSize: width * 0.04,
                            //   color: _selectedIndex == 0
                            //       ? Colors.black
                            //       : Apptheme.whitecolor,
                            //   fontWeight: FontWeight.w700,
                            // ),
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: width * 0.04,
                              color: _selectedIndex == 0
                                  ? colorScheme.primary
                                  : colorScheme.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                          selectedoption='recruiter';

                        });
                      },
                      child: Container(
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 1
                              ? colorScheme.primaryFixed
                              : colorScheme.primary,
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
                              color: _selectedIndex == 1
                                  ? Colors.black
                                  : colorScheme.onPrimary,
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(option: selectedoption,)),
                    );
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(width * 0.02),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.2), // shadow color
                          spreadRadius: 2, // how wide the shadow spreads
                          blurRadius: 6, // softness of the shadow
                          offset: const Offset(2, 3), // x,y position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.04,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen(option: selectedoption,)),
                    );
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(width * 0.02),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.2), // shadow color
                          spreadRadius: 2, // how wide the shadow spreads
                          blurRadius: 6, // softness of the shadow
                          offset: const Offset(2, 3), // x,y position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.04,
                          color: colorScheme.primary,
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
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: true,
                ),
                Text(
                  "Fresh beginnings,Bright opportunities.",
                  style: GoogleFonts.lora(
                    fontSize: width * 0.042,
                    color: colorScheme.primary,
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
