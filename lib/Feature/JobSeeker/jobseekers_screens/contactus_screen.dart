// screens/contact_us_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/JobSeeker/provider/application_provider.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';

class ContactUsScreen extends ConsumerStatefulWidget {
  const ContactUsScreen({super.key});

  @override
  ConsumerState<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends ConsumerState<ContactUsScreen> {
  String _selectedType = 'issue'; // 'issue' or 'report'
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitIssueReport() async {
    if (_formKey.currentState!.validate()) {
      final jobseekerState = ref.read(jobseekerProvider);
      final jobseekerInfo = jobseekerState.jobseekerInfo;

      if (jobseekerInfo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please complete your profile first')),
        );
        return;
      }

      try {
        // Show loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        // Submit the issue/report
        final repository = ref.read(jobRepositoryProvider);
        await repository.submitIssueReport(
          jobseekerEmail: jobseekerInfo.email,
          jobseekerName: jobseekerInfo.name.isNotEmpty ? jobseekerInfo.name : jobseekerInfo.email,
          type: _selectedType,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
        );

        // Hide loading
        if (mounted) Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_selectedType == 'issue' ? 'Issue' : 'Report'} submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back
        if (mounted) Navigator.of(context).pop();

      } catch (e) {
        // Hide loading
        if (mounted) Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              // Type Selection
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Issue'),
                      selected: _selectedType == 'issue',
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = 'issue';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Report'),
                      selected: _selectedType == 'report',
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = 'report';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  hintText: _selectedType == 'issue' 
                    ? 'e.g., App not working properly'
                    : 'e.g., Report inappropriate content',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  hintText: _selectedType == 'issue'
                    ? 'Describe the issue in detail...'
                    : 'Provide detailed information about your report...',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.trim().length < 10) {
                    return 'Description must be at least 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitIssueReport,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              
              // Help Text
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What to include:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedType == 'issue'
                          ? '• Steps to reproduce the issue\n• What you expected to happen\n• Screenshots if possible'
                          : '• Specific details of the concern\n• Relevant usernames or content\n• Why you are reporting this',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}