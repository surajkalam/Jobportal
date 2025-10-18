import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/Authentication/user_provider.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';
import 'package:jobapp/core/services/local_storage_service.dart';
import 'package:jobapp/Authentication/auth_state.dart';
import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
import 'package:jobapp/core/util/appcolors.dart';
import 'package:file_picker/file_picker.dart';

class JobseekerInfo extends ConsumerStatefulWidget {
  const JobseekerInfo({super.key});

  @override
  ConsumerState<JobseekerInfo> createState() => _JobseekerInfoState();
}

class _JobseekerInfoState extends ConsumerState<JobseekerInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController jobdesignationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();

  File? _selectedResume;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Store signup data passed from previous screen
  String _signupEmail = '';
  String _signupPassword = '';
  String _signupPhone = '';

  @override
  void initState() {
    super.initState();
    // Pre-fill email and phone from local storage
    _loadSignupData();
    _preloadUserData();
  }

  Future<void> _loadSignupData() async {
    // Get signup data passed from the previous screen
    final extraData = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extraData != null) {
      _signupEmail = extraData['email'] ?? '';
      _signupPassword = extraData['password'] ?? '';
      _signupPhone = extraData['phone'] ?? '';
    }
  }

  Future<void> _preloadUserData() async {
    try {
      // Pre-fill from signup data
      if (_signupEmail.isNotEmpty) {
        emailController.text = _signupEmail;
      } else {
        // Try to get email from the provider
        final currentEmail = ref.read(currentUserProvider);
        if (currentEmail.isNotEmpty) {
          emailController.text = currentEmail;
        }
      }
      
      if (_signupPhone.isNotEmpty) {
        contactController.text = _signupPhone;
      }
    } catch (e) {
      // Show error in snackbar instead of logging
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error pre-loading data: ${e.toString()}', 
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log('welcome in JobseekerInfo fill form');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface, // Changed from AppColors.faintbackblue
        title: Text(
          "Jobseeker information",
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface, // Changed from colorScheme.primaryFixedDim
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
                  'full name',
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
                  icon: const Icon(Icons.school_outlined),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  jobdesignationController,
                  'Job Designation',
                  icon: const Icon(Icons.work_history_outlined),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  locationController,
                  'Location',
                  icon: const Icon(Icons.location_pin),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  experienceController,
                  'Experience',
                  icon: const Icon(Icons.business_center_outlined),
                  isRequired: true,
                ),
                textformfield(
                  height,
                  width,
                  dateOfBirthController,
                  'Date of Birth (DD/MM/YYYY)',
                  icon: const Icon(Icons.calendar_month_outlined),
                  isRequired: true,
                  isDate: true,
                ),
                _buildResumePickerSection(height, width, colorScheme),
                SizedBox(height: height * 0.03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.03,
                      horizontal: height * 0.09,
                    ),
                    backgroundColor: colorScheme.tertiary, // Changed from colorScheme.secondaryFixed
                    foregroundColor: colorScheme.onTertiary, // Added foreground color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
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

  Widget _buildResumePickerSection(double height, double width, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Resume *',
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant, // Changed from AppColors.black.withValues(alpha: 0.6)
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            height: height * 0.08,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surface, // Changed from AppColors.white
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outline, // Changed from AppColors.grey.withValues(alpha: 0.5)
              ),
            ),
            child: _selectedResume == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.upload_file_outlined,
                          color: colorScheme.onSurfaceVariant, // Changed from AppColors.grey.withValues(alpha: 0.7)
                        ),
                        onPressed: _pickResume,
                      ),
                      Text(
                        'Upload Resume',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.6), // Changed from AppColors.black.withValues(alpha: 0.6)
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _selectedResume!.path.split('/').last,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurface, // Changed from AppColors.black
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: colorScheme.onSurfaceVariant, // Changed from AppColors.grey
                        ),
                        onPressed: _clearResume,
                      ),
                    ],
                  ),
          ),
          if (_selectedResume != null)
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Size: ${getFileSize(_selectedResume!)}',
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.onSurfaceVariant, // Changed from AppColors.grey
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickResume() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedResume = File(result.files.single.path!);
          resumeController.text = _selectedResume!.path;
        });
      }
    } catch (e) {
      // Show error in snackbar instead of logging
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking resume: ${e.toString()}', 
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _clearResume() {
    setState(() {
      _selectedResume = null;
      resumeController.text = '';
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (resumeController.text.isEmpty) {
        _showSnackBar(
          context: context,
          text: 'Please upload your resume before submitting .',
          textColor: Colors.red,
        );
        return;
      }
      try {
        // First, perform Firebase authentication
        final authNotifier = ref.read(authStateProvider.notifier);
        final user = await authNotifier.signUpWithEmailAndPassword(
          email: _signupEmail.isNotEmpty ? _signupEmail : emailController.text.trim(),
          password: _signupPassword.isNotEmpty ? _signupPassword : 'defaultPassword123', // Fallback password
          phoneNumber: _signupPhone.isNotEmpty ? _signupPhone : contactController.text,
        );
        
        if (user == null) {
          // Authentication failed
          final error = ref.read(authStateProvider).error;
          if (error != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return;
        }
        
        // Update the current user provider with the authenticated user's email
        ref.read(currentUserProvider.notifier).state = user.email ?? '';
        
        // Save user phone to local storage
        await LocalStorageService().setUserPhone(_signupPhone.isNotEmpty ? _signupPhone : contactController.text);
        
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
          createdAt: DateTime.now(),
        );

        // Save jobseeker info
        await ref.read(jobseekerProvider.notifier).saveJobseekerInfo(jobseekerInfo);

        if (mounted) {
          _showSnackBar(
            context: context,
            text: '✅ Profile submitted successfully!',
            textColor: Colors.green,
          );

          // Navigate to jobseeker home after successful submission
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/job-nav');
          });
        }
      } catch (e) {
        if (mounted) {
          _showSnackBar(
            context: context,
            text: 'Failed to submit profile: ${e.toString()}',
            textColor: Colors.red,
          );
        }
      }
    }
  }
  
  void _showSnackBar({
    required BuildContext context,
    required String text,
    required Color textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(color: textColor)),
        backgroundColor: Theme.of(context).colorScheme.inverseSurface, // Changed from Colors.white
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  // Helper function to format file size
  String getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }
  
  // Helper function to create text form fields
  Widget textformfield(
    double height,
    double width,
    TextEditingController controller,
    String hinttext, {
    Widget? icon,
    bool isRequired = false,
    bool isEmail = false,
    bool isPhone = false,
    bool isDate = false,
    int maxline = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxline,
        keyboardType: isPhone
            ? TextInputType.phone
            : isEmail
                ? TextInputType.emailAddress
                : TextInputType.text,
        decoration: InputDecoration(
          labelText: isRequired ? '$hinttext *' : hinttext,
          labelStyle: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurfaceVariant, // Changed from AppColors.black.withValues(alpha: 0.6)
          ),
          hintText: 'Enter $hinttext',
          hintStyle: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant.withOpacity(0.6), // Changed from AppColors.black.withValues(alpha: 0.6)
          ),
          filled: true,
          fillColor: colorScheme.surface, // Changed from AppColors.white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.outline, // Changed from AppColors.grey.withValues(alpha: 0.5)
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.outline, // Changed from AppColors.grey.withValues(alpha: 0.5)
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary, // Changed from AppColors.grey.withValues(alpha: 0.8)
            ),
          ),
          prefixIcon: icon != null ? IconTheme.merge(
            data: IconThemeData(color: colorScheme.onSurfaceVariant), // Changed from AppColors.grey.withValues(alpha: 0.7)
            child: icon,
          ) : null,
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Please enter $hinttext';
          }
          if (isEmail && value != null && value.isNotEmpty) {
            final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email';
            }
          }
          if (isPhone && value != null && value.isNotEmpty) {
            if (value.length != 10) {
              return 'Please enter a valid 10-digit phone number';
            }
          }
          if (isDate && value != null && value.isNotEmpty) {
            final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
            if (!dateRegex.hasMatch(value)) {
              return 'Please enter date in DD/MM/YYYY format';
            }
            // Additional validation for valid date
            final parts = value.split('/');
            final day = int.tryParse(parts[0]) ?? 0;
            final month = int.tryParse(parts[1]) ?? 0;
            final year = int.tryParse(parts[2]) ?? 0;
            
            if (day < 1 || day > 31) {
              return 'Please enter a valid day (1-31)';
            }
            if (month < 1 || month > 12) {
              return 'Please enter a valid month (1-12)';
            }
            if (year < 1900 || year > DateTime.now().year) {
              return 'Please enter a valid year';
            }
          }
          return null;
        },
      ),
    );
  }
}