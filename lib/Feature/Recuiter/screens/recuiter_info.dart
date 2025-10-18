import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobapp/Authentication/user_provider.dart';
import 'package:jobapp/Feature/Recuiter/provider/requiterinfo_provider.dart';
import 'package:jobapp/core/util/appcolors.dart';
import '../provider/provider.dart';
import '../recuiter_model/recuiter_model.dart';
import 'package:jobapp/core/services/local_storage_service.dart';
import 'package:jobapp/Authentication/auth_state.dart'; // Added import

class RecuiterInfo extends ConsumerStatefulWidget {
  const RecuiterInfo({super.key});

  @override
  ConsumerState<RecuiterInfo> createState() => _RecuiterInfoState();
}

class _RecuiterInfoState extends ConsumerState<RecuiterInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  File? _selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  
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
        final currentEmail = ref.read(currentRecruiterUserEmailProvider);
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
    log('welcome in RecuiterInfo fill form');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isLoading = ref.watch(loadingStateProvider);
    // final recruiterState = ref.watch(recruiterDataProvider);
    // final currentuseremail=ref.watch(currentUserEmailProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface, // Changed from AppColors.faintbackblue
        title: Text(
          "Recruiter information",
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

                // Modified ImagePickerFormField to handle file selection
                _buildImagePickerSection(height, width, colorScheme),
                SizedBox(height: height * 0.03),

                // Loading indicator and submit button
                if (isLoading)
                  CircularProgressIndicator()
                else
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

  Widget _buildImagePickerSection(double height, double width, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Photo *',
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant, // Changed from AppColors.black.withValues(alpha: 0.6)
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            height: height * 0.15,
            width: width * 0.3,
            decoration: BoxDecoration(
              color: colorScheme.surface, // Changed from AppColors.white
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outline, // Changed from AppColors.grey.withValues(alpha: 0.5)
              ),
            ),
            child: _selectedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: colorScheme.onSurfaceVariant, // Changed from AppColors.grey.withValues(alpha: 0.7)
                        ),
                        onPressed: _showImageSourceDialog,
                      ),
                      Text(
                        'Upload Photo',
                        style: TextStyle(
                          fontSize: 10,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.6), // Changed from AppColors.black.withValues(alpha: 0.6)
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 15,
                              color: Colors.white,
                            ),
                            onPressed: _clearImage,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          if (_selectedImage != null)
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Selected: ${_selectedImage!.path.split('/').last}',
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

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Show error in snackbar instead of logging
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}', 
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
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
        ref.read(currentRecruiterUserEmailProvider.notifier).state = user.email ?? '';
        
        // Save user phone to local storage
        await LocalStorageService().setUserPhone(_signupPhone.isNotEmpty ? _signupPhone : contactController.text);
        
        // Create RecruiterModel object
        final recruiterInfo = RecruiterModel(
          id: 'REC_${DateTime.now().millisecondsSinceEpoch}',
          name: nameController.text,
          email: emailController.text,
          contact: contactController.text,
          companyName: companyController.text,
          designation: designationController.text,
          location: locationController.text,
          photoUrl: photoController.text,
          createdAt: DateTime.now(),
        );

        // Save recruiter info
        await ref.read(recruiterDataProvider.notifier).saveRecruiter(recruiterInfo);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Profile submitted successfully!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Navigate to recruiter home after successful submission
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/recuiter-nav');
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to submit profile: ${e.toString()}', 
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
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
          return null;
        },
      ),
    );
  }
}