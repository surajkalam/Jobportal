// pdf_upload_service.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Authentication/user_provider.dart';
import 'package:jobapp/Feature/Recuiter/provider/provider.dart';

class PdfUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Pick PDF using FilePicker
  Future<File?> pickPdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:['pdf','doc','docx'],
      );
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick PDF: $e');
    }
  }

  // Upload PDF to Firebase Storage
  Future<String> uploadPdf(File pdfFile, String email, String name ,WidgetRef ref) async {
    try {
      // Create storage path: currentuseremail/name/resume.pdf
      // String fileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final currentusername=ref.watch(currentUserProvider);
      String fileName = 'resume_$currentusername.pdf';
      Reference storageRef = _storage.ref().child('resumes/$email/$fileName');
      
      // Upload file
      UploadTask uploadTask = storageRef.putFile(
        pdfFile,
        SettableMetadata(
          contentType: 'application/pdf',
        ),
      );
      
      // Wait for upload to complete
      TaskSnapshot snapshot = await uploadTask;
      
      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload PDF: $e');
    }
  }

  // Get file name from path
  String getFileNameFromPath(String path) {
    return path.split('/').last;
  }
}

// Provider for PDF upload service
final pdfUploadServiceProvider = Provider<PdfUploadService>((ref) {
  return PdfUploadService();
});