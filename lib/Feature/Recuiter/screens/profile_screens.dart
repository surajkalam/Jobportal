
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/Authentication/user_provider.dart';
import 'package:jobapp/core/util/appcolors.dart';
import '../provider/provider.dart';
import '../recuiter_model/recuiter_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecruiterData();
    });
  }

  void _loadRecruiterData() {
    final email = ref.read(currentRecruiterUserEmailProvider);
    if (email.isNotEmpty) {
      ref.read(recruiterDataProvider.notifier).getRecruiterByEmail(email);
    }
  }

  void _showEditBottomSheet(RecruiterModel recruiter) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => EditProfileBottomSheet(recruiter: recruiter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recruiterAsync = ref.watch(recruiterDataProvider);
    final isLoading = ref.watch(loadingStateProvider);
    final theme = Theme.of(context);
    var  width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Recruiter Profile',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        centerTitle: true ,
        backgroundColor: AppColors.faintbackblue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit, size: 24),
            onPressed: () {
              recruiterAsync.when(
                data: (recruiter) {
                  if (recruiter != null) {
                    _showEditBottomSheet(recruiter);
                  }
                },
                loading: () {},
                error: (error, stack) {},
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : recruiterAsync.when(
              data: (recruiter) => _buildProfileContent(recruiter,height,width),
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.orange)),
              error: (error, stackTrace) => _buildErrorWidget(error.toString()),
            ),
    );
  }

  Widget _buildProfileContent(RecruiterModel? recruiter  ,double height,double width) {
    if (recruiter == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.profile_delete, size: 60, color: Colors.grey[400]),
            SizedBox(height: height*0.016),
            Text(
              'No profile data found',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          SizedBox(height:height*0.016),
            ElevatedButton.icon(
              onPressed: _loadRecruiterData,
              icon: const Icon(Iconsax.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(recruiter,height,width),
             SizedBox(height: 24),
            // Profile Details Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProfileItem('Company Name', recruiter.companyName, Iconsax.building,width,height),
                    const Divider(height: 24),
                    _buildProfileItem('Contact Email', recruiter.email, Iconsax.message,width,height),
                    const Divider(height: 24),
                    _buildProfileItem('Phone', recruiter.contact, Iconsax.call,width,height),
                    const Divider(height: 24),
                    _buildProfileItem('Location', recruiter.location, Iconsax.location,width,height),
                    const Divider(height: 24),
                    _buildProfileItem('Designation', recruiter.designation, Iconsax.briefcase,width,height),
                    const Divider(height: 24),
                    _buildProfileItem(
                      'Member Since',
                      '${recruiter.createdAt.day}/${recruiter.createdAt.month}/${recruiter.createdAt.year}',
                      Iconsax.calendar,
                      width,height
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(RecruiterModel recruiter,double height,double width) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(16),
      ),
      padding:EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.orange[100],
              backgroundImage: recruiter.photoUrl.isNotEmpty 
                  ? NetworkImage(recruiter.photoUrl) as ImageProvider
                  : null,
              child: recruiter.photoUrl.isEmpty
                  ? const Icon(Iconsax.user, size: 40, color: Colors.orange)
                  : null,
            ),
           SizedBox(height: height*0.014),
            Text(
              recruiter.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
             SizedBox(height: height*0.006),
            Text(
              recruiter.email,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value, IconData icon,double width,double height) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.orange[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            SizedBox(height:height*0.004),
              Text(
                value.isEmpty ? 'Not provided' : value,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.warning_2, size: 80, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Error loading profile',
            style: TextStyle(fontSize: 18, color: Colors.red[400]),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _loadRecruiterData,
            icon: const Icon(Iconsax.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileBottomSheet extends ConsumerStatefulWidget {
  final RecruiterModel recruiter;

  const EditProfileBottomSheet({super.key, required this.recruiter});

  @override
  ConsumerState<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends ConsumerState<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _companyController;
  late TextEditingController _designationController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recruiter.name);
    _contactController = TextEditingController(text: widget.recruiter.contact);
    _companyController = TextEditingController(text: widget.recruiter.companyName);
    _designationController = TextEditingController(text: widget.recruiter.designation);
    _locationController = TextEditingController(text: widget.recruiter.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _companyController.dispose();
    _designationController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        ref.read(loadingStateProvider.notifier).state = true;

        final updatedRecruiter = widget.recruiter.copyWith(
          name: _nameController.text,
          contact: _contactController.text,
          companyName: _companyController.text,
          designation: _designationController.text,
          location: _locationController.text,
          updatedAt: DateTime.now(),
        );

        await ref.read(recruiterDataProvider.notifier).saveRecruiter(updatedRecruiter);

        if (mounted) {
          Navigator.pop(context);
          _showSnackBar(
            context: context,
            text: 'Profile updated successfully! 🎉',
            textColor: Colors.green,
          );
        }
      } catch (e) {
        if (mounted) {
          _showSnackBar(
            context: context,
            text: 'Error updating profile 😔 Try again',
            textColor: Colors.red,
          );
        }
      } finally {
        ref.read(loadingStateProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingStateProvider);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Iconsax.close_circle, color: Colors.grey[600]),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
               SizedBox(height:height*0.024),
              _buildTextField(_nameController, 'Full Name', Iconsax.user),
              const SizedBox(height: 16),
              _buildTextField(_contactController, 'Contact Number', Iconsax.call),
              const SizedBox(height: 16),
              _buildTextField(_companyController, 'Company Name', Iconsax.building),
              const SizedBox(height: 16),
              _buildTextField(_designationController, 'Designation', Iconsax.briefcase),
              const SizedBox(height: 16),
              _buildTextField(_locationController, 'Location', Iconsax.location),
              SizedBox(height: height*0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding:  EdgeInsets.symmetric(vertical: 08),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  fixedSize: Size(width, height*0.003)
                  ),
                  child: isLoading
                      ?  SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Update Profile',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      cursorHeight: 15,
      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.black),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange[700]),
        labelStyle: TextStyle(fontSize: 12,color: Colors.grey),
        hintStyle:TextStyle(fontSize: 12,color: Colors.grey), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange[700]!, width: 2),
        ),
        fillColor: Colors.grey[50],
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  void _showSnackBar({
    required BuildContext context,
    required String text,
    Color backgroundColor = Colors.white,
    required Color textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: textColor.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}