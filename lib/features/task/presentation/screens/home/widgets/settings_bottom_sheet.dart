import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class SettingsBottomSheet extends StatefulWidget {
  final VoidCallback onLogout;

  const SettingsBottomSheet({
    super.key,
    required this.onLogout,
  });

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  final TextEditingController _usercontroller = TextEditingController(
    text: FirebaseAuth.instance.currentUser!.displayName,
  );

  @override
  void dispose() {
    _usercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!.isAnonymous;
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: AppSizes.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!user) ...[
              Text(
                'Update Profile',
                style: AppTypography.bold24(),
              ),
              AppSizes.gapH24,
              AppTextfield(
                hint: 'Enter Your Name',
                icon: Icons.person,
                showicon: false,
                validator: (value) {
                  return value!.isEmpty ? "Please Enter Your Name" : null;
                },
                textEditingController: _usercontroller,
              ),
              AppSizes.gapH24,
              AppButton(
                color: Colors.deepPurple,
                width: 1.sw,
                title: 'Update',
                func: () {
                  // Update profile logic here
                },
              ),
            ],
            AppSizes.gapH24,
            AppButton(
              color: Colors.red,
              width: 1.sw,
              title: 'Logout',
              func: widget.onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
