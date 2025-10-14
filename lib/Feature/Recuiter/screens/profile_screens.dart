import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
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
    // Load recruiter data when screen starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecruiterData();
    });
  }

  void _loadRecruiterData() {
    final email = ref.read(currentrecuiterUserEmailProvider);
    if (email.isNotEmpty) {
      ref.read(recruiterDataProvider.notifier).getRecruiterByEmail(email);
    }
  }

  void _showEditBottomSheet(RecruiterModel recruiter) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EditProfileBottomSheet(recruiter: recruiter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recruiterAsync = ref.watch(recruiterDataProvider);
    final isLoading = ref.watch(loadingStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recruiter Profile'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit),
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
          ? const Center(child: CircularProgressIndicator())
          : recruiterAsync.when(
              data: (recruiter) => _buildProfileContent(recruiter),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _buildErrorWidget(error.toString()),
            ),
    );
  }

  Widget _buildProfileContent(RecruiterModel? recruiter) {
    if (recruiter == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.profile_delete, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No profile data found'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadRecruiterData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header
          _buildProfileHeader(recruiter),
          const SizedBox(height: 20),
          
          // Profile Details Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileItem('Company Name', recruiter.companyName),
                  _buildProfileItem('Contact Email', recruiter.email),
                  _buildProfileItem('Phone', recruiter.contact),
                  _buildProfileItem('Location', recruiter.location),
                  _buildProfileItem('Designation', recruiter.designation),
                  _buildProfileItem('Member Since', 
                    '${recruiter.createdAt.day}/${recruiter.createdAt.month}/${recruiter.createdAt.year}'),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(RecruiterModel recruiter) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.orange[100],
          backgroundImage: recruiter.photoUrl.isNotEmpty 
              ? NetworkImage(recruiter.photoUrl) as ImageProvider
              : null,
          child: recruiter.photoUrl.isEmpty
              ? const Icon(Iconsax.user, size: 40, color: Colors.orange)
              : null,
        ),
        const SizedBox(height: 10),
        Text(
          recruiter.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(recruiter.email),
      ],
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value.isEmpty ? 'Not provided' : value),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.warning_2, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Error loading profile', style: TextStyle(color: Colors.red)),
          Text(error, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadRecruiterData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// Edit Profile Bottom Sheet
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
    // Initialize controllers with current values
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

        // Create updated recruiter model
        final updatedRecruiter = widget.recruiter.copyWith(
          name: _nameController.text,
          contact: _contactController.text,
          companyName: _companyController.text,
          designation: _designationController.text,
          location: _locationController.text,
          updatedAt: DateTime.now(),
        );

        // Update in Firebase
        await ref.read(recruiterDataProvider.notifier).saveRecruiter(updatedRecruiter);

        // Close bottom sheet
        if (mounted) {
          Navigator.pop(context);
          _showSnackBar(
            context: context,
            text: 'Profile updated successfully! 👍',
            textColor: Colors.green,
          );
        }
      } catch (e) {
        if (mounted) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Error updating profile: $e'),
          //     backgroundColor: Colors.red,
          //   ),
          // );
          _showSnackBar(
            context: context,
            text: 'Error updating profile 👎 try again',
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

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              _buildTextField(_nameController, 'Full Name', Iconsax.user),
              _buildTextField(_contactController, 'Contact Number', Iconsax.call),
              _buildTextField(_companyController, 'Company Name', Iconsax.building),
              _buildTextField(_designationController, 'Designation', Iconsax.briefcase),
              _buildTextField(_locationController, 'Location', Iconsax.location),
              
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
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
}