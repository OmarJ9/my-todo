import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/theme_cubit.dart';
import 'package:todo_app/core/theme/app_thems.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/features/auth/blocs/authentication/authentication_cubit.dart';
import 'package:todo_app/features/profile/cubit/profile_cubit.dart';
import 'package:todo_app/features/profile/presentation/widgets/account_section.dart';
import 'package:todo_app/features/profile/presentation/widgets/buttons_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize theme in the cubit
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
              appBar: _buildAppBar(),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AppSizes.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileSection(state),
                        AppSizes.gapH32,
                        _buildAppearanceSection(state),
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

  Widget _buildAppearanceSection(ProfileLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: AppTypography.bold16(),
        ),
        AppSizes.gapH16,
        _buildThemeCard(state),
      ],
    );
  }

  Widget _buildThemeCard(ProfileLoaded state) {
    return InkWell(
      onTap: _showThemeBottomSheet,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.palette, color: context.theme.primaryColor),
            ),
            AppSizes.gapW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: AppTypography.medium16(),
                  ),
                  AppSizes.gapH8,
                  Text(
                    'Change the theme of the app',
                    style:
                        AppTypography.medium12().copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(ProfileLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile avatar section with tap to change
          Center(
            child: Column(
              children: [
                // Profile avatar with animations
                GestureDetector(
                  onTap: _showProfileBottomSheet,
                  child: FadeIn(
                    duration: const Duration(milliseconds: 800),
                    child: Stack(
                      children: [
                        // Avatar container
                        Material(
                          elevation: 8,
                          shadowColor:
                              context.theme.primaryColor.withOpacity(0.2),
                          shape: const CircleBorder(),
                          child: Container(
                            height: 120.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    context.theme.primaryColor.withOpacity(0.7),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: context.theme.primaryColor
                                      .withOpacity(0.2),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                                profileimages[state.selectedProfileImage],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // Edit icon overlay
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: context.theme.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                AppSizes.gapH16,

                // Email text with animation
                FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    state.user.email ?? '',
                    style: AppTypography.medium16().copyWith(
                      color: context.theme.primaryColor,
                      fontSize: 18.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Profile',
        style: AppTypography.bold20(),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => context.pop(),
      ),
    );
  }
}

class ProfileSelectionSheet extends StatelessWidget {
  final int selectedProfileImage;
  final Function(int) onProfileSelected;

  const ProfileSelectionSheet({
    super.key,
    required this.selectedProfileImage,
    required this.onProfileSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 50.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          AppSizes.gapH24,

          // Header
          Row(
            children: [
              Text(
                'Choose Profile Picture',
                style: AppTypography.bold20(),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          AppSizes.gapH24,

          // Grid of profile images
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: 1,
            ),
            itemCount: profileimages.length,
            itemBuilder: (context, index) {
              final isSelected = selectedProfileImage == index;
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                duration: const Duration(milliseconds: 400),
                child: GestureDetector(
                  onTap: () => onProfileSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? context.theme.primaryColor
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:
                                    context.theme.primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: CircleAvatar(
                      radius: 45.r,
                      backgroundImage: AssetImage(profileimages[index]),
                      child: isSelected
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    context.theme.primaryColor.withOpacity(0.2),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              );
            },
          ),
          AppSizes.gapH24,
        ],
      ),
    );
  }
}

class ThemeSelectionSheet extends StatelessWidget {
  final AppThemeColor selectedThemeColor;
  final Function(AppThemeColor) onThemeColorSelected;

  const ThemeSelectionSheet({
    super.key,
    required this.selectedThemeColor,
    required this.onThemeColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 50.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          AppSizes.gapH24,

          // Header
          Row(
            children: [
              Text(
                'Choose Theme Color',
                style: AppTypography.bold20(),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          AppSizes.gapH24,

          // Theme color selection
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: 1,
            ),
            itemCount: AppThemeColor.values.length,
            itemBuilder: (context, index) {
              final themeColor = AppThemeColor.values[index];
              final color = AppTheme.themes[themeColor]!.primaryColor;
              final isSelected = selectedThemeColor == themeColor;

              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                duration: const Duration(milliseconds: 400),
                child: GestureDetector(
                  onTap: () => onThemeColorSelected(themeColor),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          )
                        : null,
                  ),
                ),
              );
            },
          ),

          AppSizes.gapH32,

          // Theme name labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThemeLabel(
                  'Purple', AppThemeColor.purple == selectedThemeColor),
              _buildThemeLabel(
                  'Green', AppThemeColor.green == selectedThemeColor),
              _buildThemeLabel(
                  'Orange', AppThemeColor.orange == selectedThemeColor),
            ],
          ),
          AppSizes.gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThemeLabel('Red', AppThemeColor.red == selectedThemeColor),
              _buildThemeLabel(
                  'Teal', AppThemeColor.teal == selectedThemeColor),
              _buildThemeLabel(
                  'Pink', AppThemeColor.pink == selectedThemeColor),
            ],
          ),
          AppSizes.gapH32,
        ],
      ),
    );
  }

  Widget _buildThemeLabel(String label, bool isSelected) {
    return FadeInUp(
      from: 10,
      duration: const Duration(milliseconds: 400),
      child: Text(
        label,
        style: AppTypography.medium14().copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
