import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';

class ButtonsSection extends StatelessWidget {
  final VoidCallback onSaveChanges;

  const ButtonsSection({
    super.key,
    required this.onSaveChanges,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Save button
        AppButton(
          color: Appcolors.purple,
          width: double.infinity,
          title: 'Save Changes',
          func: onSaveChanges,
        ),

        AppSizes.gapH16,

        // Logout button
        AppButton(
          color: Colors.red,
          width: double.infinity,
          title: 'Logout',
          func: () {
            context.read<AuthenticationCubit>().signout();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
