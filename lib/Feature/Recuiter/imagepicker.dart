import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerFormField extends StatefulWidget {
  final double height;
  final double width;
  final TextEditingController controller;
  final String labelText;
  final Icon? icon;
  final ColorScheme colorScheme;

  const ImagePickerFormField({
    required this.height,
    required this.width,
    required this.controller,
    required this.labelText,
    this.icon,
    required this.colorScheme,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerFormFieldState createState() => _ImagePickerFormFieldState();
}

class _ImagePickerFormFieldState extends State<ImagePickerFormField> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

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
        widget.controller.text = image.path;
      }
    } catch (e) {
      log('Error picking image: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please check app permissions in settings')),
      );
    }
  }

  Future<void> _showImageSourceDialog() async {
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
    widget.controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.height * 0.02,
        horizontal: widget.width * 0.02,
      ),
      child: GestureDetector(
        onTap: _showImageSourceDialog,
        child: Container(
          height: widget.height * 0.2,
          width: widget.width * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.width * 0.02),
            color: Color.fromRGBO(223, 226, 230, 1),
            border: Border.all(color: widget.colorScheme.shadow, width: 2),
          ),
          child: Stack(
            children: [
              // Image or placeholder
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(widget.width * 0.02),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder();
                        },
                      ),
                    )
                  : _buildPlaceholder(),

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

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.icon ?? Icon(
          Icons.image_outlined, 
          size: widget.width * 0.08,
          color: Colors.grey[600],
        ),
        SizedBox(height: widget.height * 0.01),
        Text(
          widget.labelText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.width * 0.03,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: widget.height * 0.005),
        Text(
          'Tap to select image',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.width * 0.025,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}