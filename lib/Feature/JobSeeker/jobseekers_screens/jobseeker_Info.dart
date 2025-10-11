// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';
import 'package:jobapp/Feature/JobSeeker/service.dart/pdf_uploadservice.dart';
import 'package:lottie/lottie.dart';

class JobseekerInfo extends ConsumerStatefulWidget {
  const JobseekerInfo({super.key});

  @override
  ConsumerState<JobseekerInfo> createState() => _JobseekerInfoState();
}

class _JobseekerInfoState extends ConsumerState<JobseekerInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController jobdesignationController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;
  File? _selectedResume;
  bool _isUploadingResume = false;

  @override
  void initState() {
    super.initState();
    // Use Future.microtask to delay the initialization after build
    Future.microtask(() {
      _loadExistingInfo();
    });
  }

  Future<void> _loadExistingInfo() async {
    if (_isInitialized) return;

    try {
      await ref.read(jobseekerProvider.notifier).loadJobseekerInfo();

      final state = ref.read(jobseekerProvider);
      if (state.jobseekerInfo != null) {
        final info = state.jobseekerInfo!;
        nameController.text = info.name;
        emailController.text = info.email;
        contactController.text = info.contact;
        qualificationController.text = info.qualification;
        jobdesignationController.text = info.jobDesignation;
        locationController.text = info.location;
        experienceController.text = info.experience;
        dateOfBirthController.text = info.dateOfBirth;
        resumeController.text = info.resumeUrl;
      } else {
        final currentEmail = ref.read(currentUserProvider);
        emailController.text = currentEmail;
      }

      _isInitialized = true;
    } catch (e) {
      log('Error loading jobseeker info: $e');
    }
  }

  //select date of birth
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      dateOfBirthController.text = formattedDate;
    }
  }

  //select resume
  Future<void> _uploadResume() async {
    try {
      setState(() {
        _isUploadingResume = true;
      });
      final pdfService = ref.read(pdfUploadServiceProvider);
      // Pick PDF file
      final File? pdfFile = await pdfService.pickPdf();
      if (pdfFile == null) return;
      setState(() {
        _selectedResume = pdfFile;
      });
      // Show uploading message
      // ignore: use_build_context_synchronously
      _showSnackBar(context: context, text: 'Uploading resume...',);
      // Get current user info
      final currentEmail = ref.read(currentUserProvider);
      final name = nameController.text.isNotEmpty
          ? nameController.text
          : 'unknown';
      // Upload to Firebase Storage
      final downloadUrl = await pdfService.uploadPdf(
        pdfFile,
        currentEmail,
        name,
      );
      final fileName = pdfService.getFileNameFromPath(pdfFile.path);
      // Update resume field with download URL
      resumeController.text = downloadUrl;
      // Show success message
      _showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: 'Resume uploaded successfully!',
      );
      log('Resume uploaded: $downloadUrl');
    } catch (e) {
      _showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: 'Failed to upload resume try again please',
        textColor: Colors.red,
      );
    } finally {
      setState(() {
        _isUploadingResume = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobseekerState = ref.watch(jobseekerProvider);
    final currentEmail = ref.watch(
      currentUserProvider,
    ); // Watch instead of read
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Initialize email controller with current email
    if (emailController.text.isEmpty) {
      emailController.text = currentEmail;
    }

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
            physics:BouncingScrollPhysics(),
            padding:  EdgeInsets.only(bottom: height*0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.01,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          _showWelcomeDialog('suraj');
                        },
                        child: Text(
                          'Complete Your Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Please fill in all the required information to create your professional profile. This will help employers find you and match you with suitable job opportunities.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Fields marked with * are required.',
                        style: TextStyle(
                          fontSize: 09,
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
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
                  readOnly:
                      true,
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
                   isRequired: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.015,
                  ),
                  child: TextFormField(
                    controller: dateOfBirthController,
                    style: TextStyle(fontSize: 11),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth *',
                      labelStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      filled: true,
                      fillColor: Color.fromRGBO(223, 226, 230, 1),
                    ),
                    onTap: _selectDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select date of birth';
                      }
                      return null;
                    },
                  ),
                ),

                // Resume Upload Field
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resume *',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(223, 226, 230, 1),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.attach_file,
                            color: _selectedResume != null
                                ? Colors.green
                                : Colors.grey,
                          ),
                        title: _selectedResume != null
                              ? Text(
                                  'Resume Selected',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  'Tap to upload PDF resume',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                          subtitle: _selectedResume != null
                              ? Text(
                                  'File: ${_selectedResume!.path.split('/').last}',
                                  style: TextStyle(fontSize: 10),
                                )
                              : null,
                          trailing: _isUploadingResume
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(Icons.upload),
                          onTap: _uploadResume,
                        ),
                      ),
                      if (resumeController.text.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Resume URL: ${resumeController.text}',
                            style: TextStyle(fontSize: 9, color: Colors.blue),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),

                // Error message
                if (jobseekerState.error != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Text(
                      jobseekerState.error!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                SizedBox(height: height * 0.03),
                // Submit button
                jobseekerState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: ElevatedButton(
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
                          onPressed: _submitForm,
                          child:  Text("Submit Profile"),
                        ),
                      ),
                   SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (resumeController.text.isEmpty) {
        _showSnackBar(
          context: context,
          text: 'Please upload your resume before submitting .',
          backgroundColor: Colors.red,
        );
        return;
      }
      try {
        final currentEmail = ref.read(currentUserProvider);
        // Create JobseekerModel object
        final jobseekerInfo = JobseekerModel(
          id: 'PRO_${DateTime.now().millisecondsSinceEpoch}',
          name: nameController.text,
          email: emailController.text,
          contact: contactController.text,
          qualification: qualificationController.text,
          jobDesignation: jobdesignationController.text,
          location: locationController.text,
          experience: experienceController.text,
          dateOfBirth: dateOfBirthController.text,
          resumeUrl: resumeController.text,
          resumeFileName: _selectedResume?.path.split('/').last ?? '',
          createdAt: DateTime.now(),
        );
        await ref
            .read(jobseekerProvider.notifier)
            .saveJobseekerInfo(jobseekerInfo);
        final currentState = ref.read(jobseekerProvider);
        if (currentState.success) {
          nameController.clear();
          emailController.clear();
          contactController.clear();
          qualificationController.clear();
          jobdesignationController.clear();
          locationController.clear();
          experienceController.clear();
          dateOfBirthController.clear();
          resumeController.clear();
          _showSnackBar(
            // ignore: use_build_context_synchronously
            context: context,
            text: 'Profile submitted successfully 👍 ',
          );
          log('Jobseeker Profile Saved to Firebase:');
          log('Email: $currentEmail');
          log('Name: ${nameController.text}');
          log('Resume URL: ${resumeController.text}');
        }
      } catch (e) {
        _showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          text: 'try again something went wrong ',
          textColor: Colors.red,
        );
      }
    } else {
      _showSnackBar(
        context: context,
        text: 'Please fill all required fields correctly.',
        textColor: Colors.red,
      );
    }
  }

//   Future<String> _generateJobseekerId() async {
//   final snapshot = await FirebaseFirestore.instance.collection('jobseekers').get();
//   final nextId = snapshot.docs.length + 1;
//   return 'jobseeker_id:$nextId';
// }
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
    bool readOnly = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.008,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        style: TextStyle(fontSize: 11),
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone || isNumber
            ? TextInputType.phone
            : TextInputType.text,
        maxLines: maxline ?? 1,
        decoration: InputDecoration(
          labelText: label + (isRequired ? ' *' : ''),
          labelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)
          ),
          prefixIcon: icon,
          filled: true,
          fillColor: readOnly
              ? Color.fromRGBO(240, 240, 240, 1)
              : Color.fromRGBO(223, 226, 230, 1),
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
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    qualificationController.dispose();
    jobdesignationController.dispose();
    locationController.dispose();
    experienceController.dispose();
    dateOfBirthController.dispose();
    resumeController.dispose();
    super.dispose();
  }
void _showWelcomeDialog(String userName) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(
            maxWidth: 300,
            minWidth: 280,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lottie Animation
              SizedBox(
                height: 120, // Medium size
                width: 120,
                child: Lottie.asset(
                  'asset/icons/Rocket Launch.json',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              // Welcome Text
              Text(
                'Welcome, $userName!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              // Description Text
              Text(
                'Your profile is now live, and recruiters are waiting to discover you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24),
              // Explore Jobs Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Explore Jobs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
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
