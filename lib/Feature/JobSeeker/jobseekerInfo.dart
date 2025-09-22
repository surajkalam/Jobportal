import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jobapp/core/Widget/jobseekernavbar.dart';

class JobseekerInfo extends StatefulWidget {
  const JobseekerInfo({super.key});

  @override
  State<JobseekerInfo> createState() => _JobseekerInfoState();
}

class _JobseekerInfoState extends State<JobseekerInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController jobdesignationController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController profileDesignationController =
      TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onSecondary,
        title: Text(
          "Jobseeker information",
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primaryFixedDim,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.01,
            ),
            child: Column(
              children: [
                textformfield(
                  height,
                  width,
                  nameController,
                  'Full name',
                  icon: const Icon(Icons.person_2_outlined),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  emailController,
                  'E-mail',
                  icon: const Icon(Icons.mail_outline),
                  isRequired: true,
                  isEmail: true,
                ),
                textformfield(
                  height,
                  width,
                  contactController,
                  'Contact',
                  icon: const Icon(Icons.call),
                  isRequired: true,
                  isPhone: true,
                ),
                textformfield(
                  height,
                  width,
                  qualificationController,
                  'Qualification',
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  jobdesignationController,
                  'Designation',
                  icon: const Icon(Icons.domain),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  locationController,
                  'Location',
                  icon: const Icon(Icons.location_pin),
                  maxline: 3,
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  experienceController,
                  'Experience (years)',
                  icon: const Icon(Icons.work_history),
                  isNumber: true,
                ),
                textformfield(
                  height,
                  width,
                  profileDesignationController,
                  'Summary/Profile Description',
                  icon: const Icon(Icons.description),
                  maxline: 4,
                ),
                SizedBox(height: height * 0.03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.03,
                      horizontal: height * 0.09,
                    ),
                    backgroundColor: colorScheme.secondaryFixed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobseekerNavbar(),
                      ),
                    );
                    _submitForm();
                  },
                  child: const Text("Submit"),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, log the data
      log('Name: ${nameController.text}');
      log('Email: ${emailController.text}');
      log('Contact: ${contactController.text}');
      log('Qualification: ${qualificationController.text}');
      log('Job Designation: ${jobdesignationController.text}');
      log('Location: ${locationController.text}');
      log('Experience: ${experienceController.text}');
      log('Profile Description: ${profileDesignationController.text}');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          content: Text('Information submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          //     backgroundColor: Colors.green,
        ),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SecondPage()),
      // );
      // You can add navigation or other actions here
    } else {
      // Form is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Widget textformfield(
    double height,
    double width,
    TextEditingController controller,
    String label, {
    Icon? icon,
    int? maxline,
    bool isRequired = false,
    bool isEmail = false,
    bool isPhone = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.015,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone || isNumber
            ? TextInputType.phone
            : TextInputType.text,
        maxLines: maxline ?? 1,
        decoration: InputDecoration(
          labelText: label + (isRequired ? ' *' : ''),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: icon,
          filled: true,
          fillColor: Color.fromRGBO(223, 226, 230, 1),
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }

          if (isEmail && value != null && value.isNotEmpty) {
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
          }

          if (isPhone && value != null && value.isNotEmpty) {
            final phoneRegex = RegExp(r'^[0-9]{10}$');
            if (!phoneRegex.hasMatch(value)) {
              return 'Please enter a valid 10-digit phone number';
            }
          }

          if (isNumber && value != null && value.isNotEmpty) {
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
          }

          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    qualificationController.dispose();
    jobdesignationController.dispose();
    locationController.dispose();
    experienceController.dispose();
    profileDesignationController.dispose();
    super.dispose();
  }
}
