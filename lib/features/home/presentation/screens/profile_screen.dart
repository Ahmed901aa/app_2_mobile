import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/auth/presentation/screens/login_screen.dart';
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
    if (!_formKey.currentState!.validate()) return;
    if (_user == null) return;

    setState(() => _isLoading = true);

    try {
      await _user!.updateDisplayName(_nameController.text.trim());
      await _user!.reload();
      _user = FirebaseAuth.instance.currentUser;
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully', style: getRegularStyle(color: ColorManager.white)),
            backgroundColor: ColorManager.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $e', style: getRegularStyle(color: ColorManager.white)),
            backgroundColor: ColorManager.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _logout() async {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
         Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
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
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.lightGrey,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/dog_chef_placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: ColorManager.primary, width: 2),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Sizes.s40.h),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Sizes.s20.h),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                readOnly: true,
              ),
              SizedBox(height: Sizes.s40.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorManager.white,
                          ),
                        )
                      : Text(
                          'Save Changes',
                          style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
                        ),
                ),
              ),
               SizedBox(height: Sizes.s20.h),
               TextButton.icon(
                onPressed: _logout,
                icon: Icon(Icons.logout, color: ColorManager.error),
                label: Text(
                  'Logout', 
                  style: getMediumStyle(color: ColorManager.error, fontSize: FontSize.s16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getMediumStyle(color: ColorManager.text, fontSize: FontSize.s14),
        ),
        SizedBox(height: Sizes.s8.h),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          style: getRegularStyle(color: ColorManager.text, fontSize: FontSize.s16),
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            hintStyle: getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
            prefixIcon: Icon(icon, color: ColorManager.primary),
            filled: true,
            fillColor: readOnly ? ColorManager.lightGrey.withValues(alpha: 0.3) : ColorManager.white,
            contentPadding: EdgeInsets.symmetric(horizontal: Insets.s16.w, vertical: Insets.s16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.primary),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
