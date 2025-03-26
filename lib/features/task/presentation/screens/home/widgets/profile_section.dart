import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/features/task/presentation/screens/home/widgets/settings_bottom_sheet.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    String username = 'User';
    final cubit = context.read<AuthenticationCubit>();

    return Row(
      children: [
        SizedBox(
          height: 50.h,
          child: Image.asset(
            profileimages[profileimagesindex],
            fit: BoxFit.cover,
          ),
        ),
        AppSizes.gapW4,
        Expanded(
          child: Text(
            'Hello $username',
            overflow: TextOverflow.ellipsis,
            style: AppTypography.medium18(),
          ),
        ),
        InkWell(
          onTap: () => _showBottomSheet(context, cubit),
          child: Icon(
            Icons.settings,
            size: 30.sp,
            color: Appcolors.black,
          ),
        )
      ],
    );
  }

  Future<dynamic> _showBottomSheet(
    BuildContext context,
    AuthenticationCubit authenticationCubit,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SettingsBottomSheet(
          onLogout: () => authenticationCubit.signout(),
        );
      },
    );
  }
}
