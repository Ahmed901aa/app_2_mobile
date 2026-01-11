import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/data/services/profile_service.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/profile/profile_avatar.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/profile/profile_logout_button.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/profile/profile_save_button.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/profile/profile_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? _user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _nameController.text = _user!.displayName ?? '';
      _emailController.text = _user!.email ?? '';
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate() || _user == null) return;

    setState(() => _isLoading = true);
    try {
      await ProfileService.updateProfile(context, _user!, _nameController.text);
      _user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      ProfileService.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Insets.s24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Sizes.s20.h),
              const Center(child: ProfileAvatar()),
              SizedBox(height: Sizes.s40.h),
              ProfileTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              SizedBox(height: Sizes.s20.h),
              ProfileTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                readOnly: true,
              ),
              SizedBox(height: Sizes.s40.h),
              ProfileSaveButton(
                isLoading: _isLoading,
                onPressed: _updateProfile,
              ),
              SizedBox(height: Sizes.s20.h),
              ProfileLogoutButton(
                onPressed: () => ProfileService.logout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
