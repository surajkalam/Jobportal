// ignore: file_names
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jobapp/Feature/Recuiter/imagepicker.dart';
import 'package:jobapp/core/Widget/recuiternavbar.dart';

class RecuiterInfo extends StatefulWidget {
  const RecuiterInfo({super.key});

  @override
  State<RecuiterInfo> createState() => _RecuiterInfoState();
}

class _RecuiterInfoState extends State<RecuiterInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

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
          "Recruiter information",
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primaryFixedDim,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.01,
            horizontal: width * 0.01,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                  companyController,
                  'Company Name',
                  icon: const Icon(Icons.business),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  designationController,
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

                ImagePickerFormField(
                  height: height, // your height variable
                  width: width, // your width variable
                  controller: photoController,
                  labelText: 'Photo ID URL',
                  icon: Icon(Icons.image_outlined),
                  colorScheme: Theme.of(context).colorScheme,
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
      log('Company Name: ${companyController.text}');
      log('Designation: ${designationController.text}');
      log('Location: ${locationController.text}');
      // log('Photo ID: ${photoController.text}');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          content: Text('Recruiter information submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          //     backgroundColor: Colors.green,
        ),
      );

      // You can add navigation or other actions here
    } else {
      // Form is invalid

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          content: Text('Please fill all required fields correctly.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecuiterNavbar()),
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
            : isPhone
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
    companyController.dispose();
    designationController.dispose();
    locationController.dispose();
    photoController.dispose();
    super.dispose();
  }
}
