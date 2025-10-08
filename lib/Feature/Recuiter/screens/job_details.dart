// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';
// import 'package:jobapp/core/util.dart/image_pickerutil.dart';
// import 'dart:io';
// import '../provider/provider.dart';
// class JobdetailScreen extends ConsumerStatefulWidget {
//     final JobModel? job;
//   const JobdetailScreen({super.key, this.job});

//   @override
//   ConsumerState<JobdetailScreen> createState() => _JobdetailScreenState();
// }

// class _JobdetailScreenState extends ConsumerState<JobdetailScreen> {
//   int selectedIndex = 0;
//   File? _selectedImage;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   // Controllers
//   final TextEditingController _companyNameController = TextEditingController();
//   final TextEditingController _designationController = TextEditingController();
//   final TextEditingController _ctcController = TextEditingController();
//   final TextEditingController _noticePeriodController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _applicationController = TextEditingController();

//   @override
//   void dispose() {
//     _companyNameController.dispose();
//     _designationController.dispose();
//     _ctcController.dispose();
//     _noticePeriodController.dispose();
//     _locationController.dispose();
//     _applicationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final jobState = ref.watch(jobNotifierProvider);
    
//     return CustomScaffold(
//       scaffoldKey: _scaffoldKey,
//       child: _buildBody(context, jobState),
//     );
//   }

//   Widget _buildBody(BuildContext context, JobState jobState) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;

//     return Padding(
//       padding: EdgeInsets.all(width * 0.022),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildCategorySelection(width, height, colorScheme, textTheme),
//             _buildSelectedContainer(height, width, colorScheme, jobState),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategorySelection(double width, double height, 
//       ColorScheme colorScheme, TextTheme textTheme) {
//     return Row(
//       children: [
//         _buildCategoryButton(height, width, 'Airline', colorScheme, textTheme, 1),
//         _buildCategoryButton(height, width, 'Hospitality', colorScheme, textTheme, 2),
//       ],
//     );
//   }

//   Widget _buildCategoryButton(double height, double width, String text,
//       ColorScheme colorScheme, TextTheme textTheme, int index) {
//     return GestureDetector(
//       onTap: () => _handleCategorySelection(index),
//       child: _buildChoiceContainer(
//         height, width, text, colorScheme, textTheme, selectedIndex == index),
//     );
//   }

//   void _handleCategorySelection(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   Widget _buildSelectedContainer(double height, double width, 
//       ColorScheme colorscheme, JobState jobState) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: _buildJobForm(height, width, colorscheme, jobState),
//         ),
//       ],
//     );
//   }

//   Widget _buildJobForm(double height, double width, 
//       ColorScheme colorschem, JobState jobState) {
//     return Column(
//       children: [
//         _buildImagePickerContainer(height, width),
//         _buildTextFormField(height, width, _companyNameController, 'Company Name *',
//             icon: Icon(Iconsax.building), isRequired: true),
//         _buildTextFormField(height, width, _designationController, 'Designation *',
//             icon: Icon(Iconsax.briefcase), isRequired: true),
//         _buildTextFormField(height, width, _ctcController, 'CTC *',
//             icon: Icon(Iconsax.wallet), isRequired: true, isNumber: true),
//         _buildTextFormField(height, width, _noticePeriodController, 'Notice Period *',
//             icon: Icon(Iconsax.calendar), isRequired: true),
//         _buildTextFormField(height, width, _locationController, 'Location *',
//             icon: Icon(Iconsax.location), isRequired: true),
//         _buildTextFormField(height, width, _applicationController, 'Application *',
//             icon: Icon(Iconsax.document_text), isRequired: true, maxline: 3),
//         SizedBox(height: height * 0.04),
        
//         if (jobState.isLoading)
//           CircularProgressIndicator()
//         else
//           _buildSubmitButton(height, width, colorschem, _handleSubmit),
        
//         if (jobState.error != null)
//           Padding(
//             padding: EdgeInsets.only(top: height * 0.02),
//             child: Text(
//               'Error: ${jobState.error}',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
          
//         if (jobState.success)
//           Padding(
//             padding: EdgeInsets.only(top: height * 0.02),
//             child: Text(
//               'Job posted successfully!',
//               style: TextStyle(color: Colors.green),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildImagePickerContainer(double height, double width) {
//     return GestureDetector(
//       onTap: _pickImage,
//       child: Container(
//         height: height * 0.15,
//         width: width * 0.9,
//         margin: EdgeInsets.symmetric(vertical: height * 0.02),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//           color: Color.fromRGBO(223, 226, 230, 1),
//         ),
//         child: _selectedImage == null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Iconsax.camera, size: 40, color: Colors.grey),
//                   SizedBox(height: 8),
//                   Text('Tap to add company image *',
//                       style: TextStyle(color: Colors.grey)),
//                 ],
//               )
//             : ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.file(_selectedImage!, fit: BoxFit.cover),
//               ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//   try {
//     File? image = await ImagePickerUtils.pickImageFromGallery();
    
//     if (image != null) {
//       // Verify the file exists before setting it
//       bool fileExists = await image.exists();
      
//       if (!fileExists) {
//         _showSnackBar('Selected image file is not accessible');
//         return;
//       }

//       // Check file size (optional)
//       final fileLength = await image.length();
//       if (fileLength > 10 * 1024 * 1024) {
//         _showSnackBar('Image file is too large. Please select a smaller image.');
//         return;
//       }

//       setState(() {
//         _selectedImage = image;
//       });
      
//       _showSnackBar('Image selected successfully');
//     }
//   } catch (e) {
//     _showSnackBar('Failed to pick image: $e');
//     log('Image picking error: $e');
//   }
// }

//   Widget _buildTextFormField(
//     double height,
//     double width,
//     TextEditingController controller,
//     String label, {
//     Icon? icon,
//     int? maxline,
//     bool isRequired = false,
//     // bool isEmail = false,
//     // bool isPhone = false,
//     bool isNumber = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: width * 0.02,
//         vertical: height * 0.015,
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         maxLines: maxline ?? 1,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           prefixIcon: icon,
//           filled: true,
//           fillColor: Color.fromRGBO(223, 226, 230, 1),
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmitButton(
//     double height,
//     double width,
//     ColorScheme colorscheme,
//     VoidCallback onPressed,
//   ) {
//     return SizedBox(
//       width: width - 200,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         onPressed: onPressed,
//         child: Text(
//           'Submit',
//           style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                 color: colorscheme.onSecondary,
//               ),
//         ),
//       ),
//     );
//   }

//   Future<void> _handleSubmit() async {
//     try {
//       // Clear previous state
//     ref.read(jobNotifierProvider.notifier).clearError();
//     ref.read(jobNotifierProvider.notifier).clearSuccess();

//       // Validate fields
//       if (_selectedImage == null) {
//       _showSnackBar('Please select a company image');
//       return;
//     }
//     if (!await _selectedImage!.exists()) {
//       _showSnackBar('Selected image file is no longer available. Please select again.');
//       setState(() {
//         _selectedImage = null;
//       });
//       return;
//     }

//       if (_companyNameController.text.isEmpty ||
//           _designationController.text.isEmpty ||
//           _ctcController.text.isEmpty ||
//           _noticePeriodController.text.isEmpty ||
//           _locationController.text.isEmpty ||
//           _applicationController.text.isEmpty) {
//         _showSnackBar('Please fill all required fields');
//         return;
//       }

//       // Get category
//       String category = selectedIndex == 1 ? 'Airline' : 'Hospitality';

//       // Upload image
//       final jobNotifier = ref.read(jobNotifierProvider.notifier);
//       String imageUrl = await jobNotifier.uploadImage(_selectedImage!);
//         final recruiterEmail = ref.read(currentUserEmailProvider);
//       // Create job model
//       JobModel jobData = JobModel(
//         companyName: _companyNameController.text,
//         designation: _designationController.text,
//         ctc: _ctcController.text,
//         noticePeriod: _noticePeriodController.text,
//         location: _locationController.text,
//         application: _applicationController.text,
//         imageUrl: imageUrl,
//         category: category,
//         createdAt: DateTime.now(),
//         recruiterEmail: recruiterEmail,
//       );

//       // Save job
//       await jobNotifier.saveJob(jobData);
      
//       // Check if successful
//       final currentState = ref.read(jobNotifierProvider);
//       if (currentState.success) {
//         _showSnackBar('$category Job posted successfully!');
//         _clearForm();
//       }
      
//     } catch (e) {
//       _showSnackBar('Error: $e');
//       log('Error submitting job: $e');
//     }
//   }

//   void _clearForm() {
//     _companyNameController.clear();
//     _designationController.clear();
//     _ctcController.clear();
//     _noticePeriodController.clear();
//     _locationController.clear();
//     _applicationController.clear();
    
//     setState(() {
//       _selectedImage = null;
//     });
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.blueAccent,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }

//   Widget _buildChoiceContainer(
//     double height,
//     double width,
//     String text,
//     ColorScheme colorScheme,
//     TextTheme textTheme,
//     bool isSelected,
//   ) {
//     return Padding(
//       padding: EdgeInsets.all(width * 0.02),
//       child: Container(
//         height: height * 0.05,
//         width: width * 0.4,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: isSelected ? colorScheme.primaryFixed : colorScheme.onPrimary,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 1,
//               offset: Offset(2, 3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: textTheme.headlineSmall?.copyWith(
//               color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Keep your CustomScaffold widget as is
// class CustomScaffold extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final Widget child;

//   const CustomScaffold({
//     super.key,
//     required this.scaffoldKey,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
    
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: Text('Job Posting'),
//         leading: Icon(Iconsax.menu, color: colorScheme.onPrimary),
//         actions: [
//           Icon(Iconsax.notification, color: colorScheme.onPrimary),
//           SizedBox(width: 10),
//           Icon(Iconsax.user, color: colorScheme.onPrimary),
//           SizedBox(width: 10),
//         ],
//         backgroundColor: colorScheme.onSecondary,
//       ),
//       body: child,
//     );
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';
import 'package:jobapp/core/util.dart/image_pickerutil.dart';
import 'dart:io';
import '../provider/provider.dart';

class JobdetailScreen extends ConsumerStatefulWidget {
  final JobModel? job;
  const JobdetailScreen({super.key, this.job});

  @override
  ConsumerState<JobdetailScreen> createState() => _JobdetailScreenState();
}

class _JobdetailScreenState extends ConsumerState<JobdetailScreen> {
  int selectedIndex = 0;
  File? _selectedImage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _ctcController = TextEditingController();
  final TextEditingController _noticePeriodController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();
  final TextEditingController _qualificationsController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If editing existing job, pre-fill the form
    if (widget.job != null) {
      _companyNameController.text = widget.job!.companyName;
      _designationController.text = widget.job!.designation;
      _ctcController.text = widget.job!.ctc;
      _noticePeriodController.text = widget.job!.noticePeriod;
      _locationController.text = widget.job!.location;
      _descriptionController.text = widget.job!.application; // Using application field for description
      // You might need to adjust these based on your actual data structure
      _benefitsController.text = ''; // Initialize with empty or get from job if available
      _qualificationsController.text = ''; // Initialize with empty or get from job if available
      _skillsController.text = ''; // Initialize with empty or get from job if available
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _designationController.dispose();
    _ctcController.dispose();
    _noticePeriodController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _benefitsController.dispose();
    _qualificationsController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobState = ref.watch(jobNotifierProvider);
    
    return CustomScaffold(
      scaffoldKey: _scaffoldKey,
      isEditing: widget.job != null,
      child: _buildBody(context, jobState),
    );
  }

  Widget _buildBody(BuildContext context, JobState jobState) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(width * 0.022),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategorySelection(width, height, colorScheme, textTheme),
            _buildSelectedContainer(height, width, colorScheme, jobState),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelection(double width, double height, 
      ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      children: [
        _buildCategoryButton(height, width, 'Airline', colorScheme, textTheme, 1),
        _buildCategoryButton(height, width, 'Hospitality', colorScheme, textTheme, 2),
      ],
    );
  }

  Widget _buildCategoryButton(double height, double width, String text,
      ColorScheme colorScheme, TextTheme textTheme, int index) {
    return GestureDetector(
      onTap: () => _handleCategorySelection(index),
      child: _buildChoiceContainer(
        height, width, text, colorScheme, textTheme, selectedIndex == index),
    );
  }

  void _handleCategorySelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildSelectedContainer(double height, double width, 
      ColorScheme colorscheme, JobState jobState) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: _buildJobForm(height, width, colorscheme, jobState),
        ),
      ],
    );
  }

  Widget _buildJobForm(double height, double width, 
      ColorScheme colorschem, JobState jobState) {
    return Column(
      children: [
        _buildImagePickerContainer(height, width),
        _buildTextFormField(height, width, _companyNameController, 'Company Name *',
            icon: Icon(Iconsax.building, size: 18), isRequired: true),
        _buildTextFormField(height, width, _designationController, 'Designation *',
            icon: Icon(Iconsax.briefcase, size: 18), isRequired: true),
        _buildTextFormField(height, width, _ctcController, 'CTC *',
            icon: Icon(Iconsax.wallet, size: 18), isRequired: true, isNumber:false),
        _buildTextFormField(height, width, _noticePeriodController, 'Notice Period *',
            icon: Icon(Iconsax.calendar, size: 18), isRequired: true),
        _buildTextFormField(height, width, _locationController, 'Location *',
            icon: Icon(Iconsax.location, size: 18), isRequired: true),
        _buildTextFormField(height, width, _descriptionController, 'Job Description *',
            icon: Icon(Iconsax.document_text, size: 18), isRequired: true, maxline: 3),
        _buildTextFormField(height, width, _benefitsController, 'Benefits',
            icon: Icon(Iconsax.gift, size: 18), maxline: 3),
        _buildTextFormField(height, width, _qualificationsController, 'Qualifications',
            icon: Icon(Iconsax.book, size: 18), maxline: 3),
        _buildTextFormField(height, width, _skillsController, 'Required Skills',
            icon: Icon(Iconsax.code, size: 18), maxline: 3),
        SizedBox(height: height * 0.04),
        
        if (jobState.isLoading)
          CircularProgressIndicator()
        else
          _buildSubmitButton(height, width, colorschem, _handleSubmit),
        
        if (jobState.error != null)
          Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Text(
              'Error: ${jobState.error}',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
          
        if (jobState.success)
          Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Text(
              'Job ${widget.job != null ? 'updated' : 'posted'} successfully!',
              style: TextStyle(color: Colors.green, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePickerContainer(double height, double width) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: height * 0.15,
        width: width * 0.9,
        margin: EdgeInsets.symmetric(vertical: height * 0.02),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(223, 226, 230, 1),
        ),
        child: _selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.camera, size: 32, color: Colors.grey),
                  SizedBox(height: 6),
                  Text('Tap to add company image *',
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      File? image = await ImagePickerUtils.pickImageFromGallery();
      
      if (image != null) {
        bool fileExists = await image.exists();
        
        if (!fileExists) {
          _showSnackBar('Selected image file is not accessible');
          return;
        }

        final fileLength = await image.length();
        if (fileLength > 10 * 1024 * 1024) {
          _showSnackBar('Image file is too large. Please select a smaller image.');
          return;
        }

        setState(() {
          _selectedImage = image;
        });
        
        _showSnackBar('Image selected successfully');
      }
    } catch (e) {
      _showSnackBar('Failed to pick image: $e');
      log('Image picking error: $e');
    }
  }

  Widget _buildTextFormField(
    double height,
    double width,
    TextEditingController controller,
    String label, {
    Icon? icon,
    int? maxline,
    bool isRequired = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.012,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxline ?? 1,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: icon,
          filled: true,
          fillColor: Color.fromRGBO(223, 226, 230, 1),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
    double height,
    double width,
    ColorScheme colorscheme,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: width - 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onPressed,
        child: Text(
          widget.job != null ? 'Update Job' : 'Submit Job',
          style: TextStyle(fontSize: 12, color: colorscheme.onSecondary),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    try {
      ref.read(jobNotifierProvider.notifier).clearError();
      ref.read(jobNotifierProvider.notifier).clearSuccess();

      // Validate required fields
      if (_selectedImage == null && widget.job == null) {
        _showSnackBar('Please select a company image');
        return;
      }

      if (_companyNameController.text.isEmpty ||
          _designationController.text.isEmpty ||
          _ctcController.text.isEmpty ||
          _noticePeriodController.text.isEmpty ||
          _locationController.text.isEmpty ||
          _descriptionController.text.isEmpty) {
        _showSnackBar('Please fill all required fields');
        return;
      }

      // Get category
      String category = selectedIndex == 1 ? 'Airline' : 'Hospitality';

      final jobNotifier = ref.read(jobNotifierProvider.notifier);
      final recruiterEmail = ref.read(currentUserEmailProvider);
      
      String imageUrl = _selectedImage != null 
          ? await jobNotifier.uploadImage(_selectedImage!)
          : widget.job?.imageUrl ?? '';

      // Create job model
      JobModel jobData = JobModel(
        id: widget.job?.id ?? '',
        companyName: _companyNameController.text,
        designation: _designationController.text,
        ctc: _ctcController.text,
        noticePeriod: _noticePeriodController.text,
        location: _locationController.text,
        application: _descriptionController.text, // Using description for application field
        imageUrl: imageUrl,
        category: category,
        createdAt: widget.job?.createdAt ?? DateTime.now(),
        recruiterEmail: recruiterEmail,
        benefits:_benefitsController.text,
        qualifications: _qualificationsController.text,
        skills: _skillsController.text
      );

      // Save or update job
      if (widget.job != null) {
        await jobNotifier.updateJob(jobData);
      } else {
        await jobNotifier.saveJob(jobData);
      }
      
      // Check if successful
      final currentState = ref.read(jobNotifierProvider);
      if (currentState.success) {
        _showSnackBar('$category Job ${widget.job != null ? 'updated' : 'posted'} successfully!');
        if (widget.job == null) {
          _clearForm();
        }
      }
      
    } catch (e) {
      _showSnackBar('Error: $e');
      log('Error submitting job: $e');
    }
  }

  void _clearForm() {
    _companyNameController.clear();
    _designationController.clear();
    _ctcController.clear();
    _noticePeriodController.clear();
    _locationController.clear();
    _descriptionController.clear();
    _benefitsController.clear();
    _qualificationsController.clear();
    _skillsController.clear();
    
    setState(() {
      _selectedImage = null;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.blueAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildChoiceContainer(
    double height,
    double width,
    String text,
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isSelected,
  ) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        height: height * 0.05,
        width: width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primaryFixed : colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget child;
  final bool isEditing;

  const CustomScaffold({
    super.key,
    required this.scaffoldKey,
    required this.child,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Job' : 'Create New Job',
          style: TextStyle(fontSize: 14),
        ),
        leading: Icon(Iconsax.menu, color: colorScheme.onPrimary, size: 18),
        actions: [
          Icon(Iconsax.notification, color: colorScheme.onPrimary, size: 18),
          SizedBox(width: 8),
          Icon(Iconsax.user, color: colorScheme.onPrimary, size: 18),
          SizedBox(width: 8),
        ],
        backgroundColor: colorScheme.onSecondary,
      ),
      body: child,
    );
  }
}