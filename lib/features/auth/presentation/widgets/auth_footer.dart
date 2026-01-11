import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onActionTap;

  const AuthFooter({
    super.key,
    required this.question,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: getRegularStyle(color: ColorManager.textSecondary),
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: getBoldStyle(color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}
