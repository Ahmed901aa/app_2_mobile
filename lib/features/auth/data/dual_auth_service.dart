import 'package:app_2_mobile/features/auth/data/backend_auth_service.dart';
import 'package:app_2_mobile/features/auth/data/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class DualAuthService {
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  final BackendAuthService _backendAuth = BackendAuthService();

  Future<void> loginWithEmailPassword(String email, String password) async {
    // 1. Firebase Login
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. Backend Login with auto-sync fallback
    try {
      await _backendAuth.login(email, password);
      debugPrint('Backend login successful');
    } catch (e) {
      debugPrint('Backend login failed: $e');
      if (e.toString().contains('401')) {
        debugPrint('User missing on backend. Attempting auto-sync...');
        await _syncUserToBackend(email, password);
      } else {
        rethrow;
      }
    }
  }

  Future<void> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Firebase Registration
    await _firebaseAuth.registerWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );

    // 2. Backend Registration with login fallback
    try {
      await _backendAuth.register(
        name: name,
        email: email,
        password: password,
      );
      debugPrint('Backend registration successful');
    } catch (e) {
      debugPrint('Backend registration failed: $e');
      if (e.toString().contains('422') || e.toString().contains('already')) {
        debugPrint('User exists on backend. Attempting login...');
        await _backendAuth.login(email, password);
      } else {
        rethrow;
      }
    }
  }

  Future<void> _syncUserToBackend(String email, String password) async {
    String name = 'User';
    final user = _firebaseAuth.currentUser;
    
    if (user != null) {
      name = user.displayName ?? 'User';
      if (name == 'User') {
        final userData = await _firebaseAuth.getUserData(user.uid);
        if (userData != null && userData['name'] != null) {
          name = userData['name'];
        }
      }
    }

    await _backendAuth.register(
      name: name,
      email: email,
      password: password,
    );
    debugPrint('Auto-sync successful');
  }
}
