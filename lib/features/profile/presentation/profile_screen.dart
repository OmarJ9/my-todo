import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/theme/theme_cubit.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/features/auth/blocs/authentication/authentication_cubit.dart';
import 'package:todo_app/features/profile/cubit/profile_cubit.dart';
import 'package:todo_app/features/profile/presentation/widgets/account_section.dart';
import 'package:todo_app/features/profile/presentation/widgets/buttons_section.dart';

import 'widgets/profile_app_bar.dart';
import 'widgets/profile_appearance_section.dart';
import 'widgets/profile_avatar_section.dart';
import 'widgets/profile_selection_sheet.dart';
import 'widgets/profile_theme_selction_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    final themeCubit = context.read<ThemeCubit>();
    context.read<ProfileCubit>().initializeTheme(themeCubit);
  }

  void _showProfileBottomSheet() {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ProfileSelectionSheet(
        selectedProfileImage: state.selectedProfileImage,
        onProfileSelected: (index) {
          context.read<ProfileCubit>().selectProfileImage(index);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showThemeBottomSheet() {
    final state = context.read<ProfileCubit>().state;
    if (state is! ProfileLoaded) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ThemeSelectionSheet(
        selectedThemeColor: state.selectedThemeColor,
        onThemeColorSelected: (themeColor) {
          context
              .read<ProfileCubit>()
              .changeThemeColor(themeColor, context.read<ThemeCubit>());
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              Alerts.of(context).showSuccess('Profile updated successfully');
              context.pop();
            } else if (state is ProfileError) {
              Alerts.of(context).showError(state.message);
            }
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is UnAuthenticationState) {
              context.goNamed(RouteNames.loginpage);
            }
          },
        ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileCubit>().getProfile();
            return const AppCircularIndicator();
          }

          if (state is ProfileLoading) {
            return Container(
              color: Colors.white,
              child: const AppCircularIndicator(),
            );
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded) {
            return Scaffold(
              appBar: ProfileAppBar(onBackPressed: () => context.pop()),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AppSizes.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileSection(
                          state: state,
                          onTap: _showProfileBottomSheet,
                        ),
                        AppSizes.gapH32,
                        AppearanceSection(
                          state: state,
                          onTap: _showThemeBottomSheet,
                        ),
                        AppSizes.gapH32,
                        const AccountSection(),
                        AppSizes.gapH32,
                        ButtonsSection(
                          onSaveChanges: () {
                            context.read<ProfileCubit>().updateProfile();
                          },
                        ),
                        AppSizes.gapH16,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return const AppCircularIndicator();
        },
      ),
    );
  }
}
