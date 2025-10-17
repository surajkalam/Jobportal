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
        backgroundColor: AppColors.faintbackblue,
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

  Widget _buildImagePickerSection(double height, double width, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: GestureDetector(
        onTap: _showImageSourceDialog,
        child: Container(
          height: height * 0.2,
          width: width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.02),
            color: Color.fromRGBO(223, 226, 230, 1),
            border: Border.all(
              color: _selectedImage != null 
                  ? Colors.green 
                  : colorScheme.shadow, 
              width: 2
            ),
          ),
          child: Stack(
            children: [
              // Image or placeholder
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(height, width);
                        },
                      ),
                    )
                  : _buildPlaceholder(height, width),

              // Clear button (only shown when image is selected)
              if (_selectedImage != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _clearImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
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

  Widget _buildPlaceholder(double height, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image_outlined, 
          size: width * 0.08,
          color: Colors.grey[600],
        ),
        SizedBox(height: height * 0.01),
        Text(
          'Recruiter Photo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.03,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: height * 0.005),
        Text(
          'Tap to select image',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.025,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
  try {
    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      // Set the photo controller text with the image path
      photoController.text = image.path;
      // Debug: Check if file exists
      bool fileExists = await _selectedImage!.exists();
      log('File exists: $fileExists');
      log('File path: ${_selectedImage!.path}');
      log('File size: ${await _selectedImage!.length()} bytes');
      // Show success message
      _showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: 'Photo selected successfully !👍',
        textColor: Colors.green,
      );
    }
  } catch (e) {
    log('Error picking image: $e');
    _showSnackBar(
      // ignore: use_build_context_synchronously
      context: context,
      text: 'Error picking image. check image is not corrupted',
      textColor: Colors.red,
    );
  }
}
  Future<void> _showImageSourceDialog( ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearImage() {
  setState(() {
    _selectedImage = null;
  });
  photoController.clear();
  _showSnackBar(
    context: context,
    text: 'Photo cleared',
    textColor: Colors.deepOrange,
  );
}

  void _submitForm() {
  // Check if image is required but not selected
  if (_selectedImage == null) {
    _showSnackBar(
      context: context,
      text: 'Please select a recruiter photo.',
      textColor: Colors.red,
    );
    return;
  }
  
  if (_formKey.currentState!.validate()) {
    _saveRecruiterInfo();
  } else {
    _showSnackBar(
      context: context,
      text: 'Please fill all required fields correctly.',
      textColor: Colors.red,
    );
  }
}

  void _saveRecruiterInfo() async {
    ref.read(loadingStateProvider.notifier).state = true;
    try {
      String photoUrl = '';
      // First upload image if selected
      if (_selectedImage != null) {
        photoUrl = await _uploadImageToStorage();
      }
      // Create recruiter model
      final recruiter = RecruiterModel(
        id: 'REQ_${DateTime.now().millisecondsSinceEpoch}',
        name: nameController.text,
        email: emailController.text,
        contact: contactController.text,
        companyName: companyController.text,
        designation: designationController.text,
        location: locationController.text,
        photoUrl: photoUrl,
        createdAt: DateTime.now(),
      );

      // Save to Firestore using provider
      await ref.read(recruiterDataProvider.notifier).saveRecruiter(recruiter);
      ref.read(currentRecruiterUserEmailProvider.notifier).state = emailController.text;
      // ignore: use_build_context_synchronously
      _showSnackBar(context: context, text:' Recruiter information submitted successfully! 👍',textColor: Colors.green);
      // ignore: use_build_context_synchronously
        context.go('/navbar');
      // _navigateToDashboard();
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //  context.go('/navbar');
      // });
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showSnackBar(context: context, text:' Error saving recruiter information check all fields ',textColor: Colors.red);
      log('Error saving recruiter: $e');
    } finally {
      ref.read(loadingStateProvider.notifier).state = false;
    }
  }

  Future<String> _uploadImageToStorage() async {
  if (_selectedImage == null) return '';

  try {
    // Double-check that the file exists before uploading
    bool fileExists = await _selectedImage!.exists();
    if (!fileExists) {
      throw Exception('Selected image file does not exist. Please select the image again.');
    }
    
    final firebaseService = ref.read(firebaseRecruiterServiceProvider);
    return await firebaseService.uploadImage(_selectedImage!, emailController.text);
  } catch (e) {
    throw Exception('Image upload failed: $e');
  }
}

  // void _navigateToDashboard() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //    context.go('/');
  //   });
  // }

  // void _showSuccessSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       margin: EdgeInsets.all(16),
  //       content: Text(message),
  //       backgroundColor: Colors.green,
  //       duration: Duration(seconds: 3),
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //     ),
  //   );
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

          if (isPhone && value != null && value.isNotEmpty && value.length <= 10  &&    RegExp(r'^[0-9]+$').hasMatch(value) && value[0] != '0' && value[0] != '1') {
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
  @override
  void dispose() {
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