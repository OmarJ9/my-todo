import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';

import '../../../../../../core/constants/app_assets.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.read<AuthenticationCubit>().googleSignIn();
          },
          child: Image.asset(AppAssets.googleicon),
        ),
        AppSizes.gapW48,
        GestureDetector(
          onTap: () {},
          child: Image.asset(AppAssets.facebookicon),
        ),
      ],
    );
  }
}
