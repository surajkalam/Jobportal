import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/Feature/JobSeeker/jobseekerInfo.dart';
import 'package:jobapp/Feature/Recuiter/RecuiterInfo.dart';
// import 'package:jobapp/core/material_theme.dart';

class SignupScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final option;
  const SignupScreen({super.key, required this.option});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrMobileController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _comfirmpasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureconfirmpassword = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;

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
                const SizedBox(height: 40),
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email or Mobile field
                TextFormField(
                  controller: _emailOrMobileController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "E-mail ",
                    filled: true,
                    fillColor: Color.fromRGBO(223, 226, 230, 1),
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
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Enter mobile number",
                    filled: true,
                    fillColor: Color.fromRGBO(223, 226, 230, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
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
                      return "Please enter mobile";
                    } else if (value.length < 10) {
                      return "invalid mobile number";
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
                SizedBox(height: height * 0.02),
                TextFormField(
                  controller: _comfirmpasswordController,
                  obscureText: _obscureconfirmpassword,
                  decoration: InputDecoration(
                    labelText: "Conform password",
                    filled: true,
                    fillColor: Color.fromRGBO(223, 226, 230, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureconfirmpassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureconfirmpassword = !_obscureconfirmpassword;
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

                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.04,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.015,
                    ), // ✅ controls inside spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      color: Colors.transparent,
                      border: Border.all(color: colorScheme.primary, width: 2),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // ✅ makes row wrap content
                      children: [
                        Image.asset(
                          "asset/images/google.png",
                          height: height * 0.03, // smaller logo
                          width: height * 0.03,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: width * 0.03),
                        GestureDetector(
                          onTap: () {
                            if (_phoneController.text.length < 10 ||
                                _phoneController.text.length > 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Enter valid mobile number'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
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
                            if (_comfirmpasswordController.text !=
                                _passwordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Passwords do not match!'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return; // Stop further execution
                            }
                          },

                          child: Text(
                            "Continue Google",
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
                      backgroundColor: colorScheme.secondaryFixed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (widget.option == 'jobseeker') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JobseekerInfo(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RecuiterInfo(),
                          ),
                        );
                      }

                      if (_formKey.currentState!.validate()) {
                        debugPrint(
                          "✅ Signup successful with: ${_emailOrMobileController.text}",
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup successful ")),
                        );
                      }
                    },
                    child: Text(
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
}
