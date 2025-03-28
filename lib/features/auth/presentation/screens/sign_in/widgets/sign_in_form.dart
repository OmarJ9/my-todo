import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

import '../../../../blocs/authentication/authentication_cubit.dart';
import '../../../../blocs/login_form/login_form_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmailField(),
        AppSizes.gapH24,
        _PasswordField(),
        AppSizes.gapH48,
        _SignInButton(),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final error = context
        .select((LoginFormCubit cubit) => cubit.state.email.displayError);
    return AppTextfield(
      hint: 'Enter Your Email',
      keyboardType: TextInputType.emailAddress,
      onChange: (value) {
        context.read<LoginFormCubit>().emailChanged(value);
      },
      errorText: error != null ? "Enter a valid email" : null,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final error = context
        .select((LoginFormCubit cubit) => cubit.state.password.displayError);
    return BlocBuilder<LoginFormCubit, LoginState>(
      builder: (context, state) {
        return AppTextfield(
          hint: 'Enter Your Password',
          keyboardType: TextInputType.visiblePassword,
          obscureText: state.isObscure,
          suffixIcon: state.isObscure ? Icons.visibility_off : Icons.visibility,
          onSuffixIconTap: () {
            context.read<LoginFormCubit>().changeObscurity();
          },
          onChange: (value) {
            context.read<LoginFormCubit>().passwordChanged(value);
          },
          errorText:
              error != null ? "Password must be at least 8 characters" : null,
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFormCubit, LoginState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          context.read<AuthenticationCubit>().login(
                email: state.email.value,
                password: state.password.value,
              );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == FormzSubmissionStatus.inProgress;
        final isEnabled = state.isValid;
        if (isLoading) {
          return AppCircularIndicator();
        }
        return AppButton(
          color: context.theme.primaryColor,
          width: 1.sw,
          title: 'Sign In',
          onClick: isEnabled
              ? () {
                  context.read<LoginFormCubit>().login();
                }
              : null,
        );
      },
    );
  }
}
