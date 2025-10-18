// providers/recruiter_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:jobapp/Authentication/user_provider.dart';

import '../recuiter_firebase/requiterinfo_firebase.dart';
import '../recuiter_model/recuiter_model.dart';

// Firebase Service Provider
final firebaseRecruiterServiceProvider = Provider<FirebaseRecruiterService>((ref) {
  return FirebaseRecruiterService();
});

// Recruiter Data Provider
final recruiterDataProvider = StateNotifierProvider<RecruiterNotifier, AsyncValue<RecruiterModel?>>((ref) {
  return RecruiterNotifier(ref.read(firebaseRecruiterServiceProvider), ref);
});

class RecruiterNotifier extends StateNotifier<AsyncValue<RecruiterModel?>> {
  final FirebaseRecruiterService _recruiterService;
  final Ref _ref;

  RecruiterNotifier(this._recruiterService, this._ref) : super(const AsyncValue.loading());

  String get _currentRecruiterEmail {
    final email = _ref.read(currentRecruiterUserEmailProvider);
    if (email.isEmpty) {
      throw Exception('Recruiter email is not available. Please log in first.');
    }
    return email;
  }

  // Save recruiter data
  Future<void> saveRecruiter(RecruiterModel recruiter) async {
    state = const AsyncValue.loading();
    try {
      await _recruiterService.saveRecruiterData(recruiter);
      state = AsyncValue.data(recruiter);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  // Get recruiter by email
  Future<void> getRecruiterByEmail(String email) async {
    state = const AsyncValue.loading();
    try {
      final recruiter = await _recruiterService.getRecruiterByEmail(email);
      state = AsyncValue.data(recruiter);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  // In RecruiterNotifier class
  Future<void> updateRecruiter(RecruiterModel recruiter) async {
    state = const AsyncValue.loading();
    try {
      await _recruiterService.updateRecruiterData(recruiter);
      state = AsyncValue.data(recruiter);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  // Clear recruiter data
  void clearRecruiter() {
    state = const AsyncValue.data(null);
  }
}

// Loading State Provider
final loadingStateProvider = StateProvider<bool>((ref) => false);