import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextfield(
            hint: 'Email',
            icon: Icons.email,
            showicon: true,
            validator: (value) {
              return value!.isEmpty ? "Please Enter Your Email" : null;
            },
            textEditingController: emailController,
          ),
          AppSizes.gapH24,
          AppTextfield(
            hint: 'Password',
            icon: Icons.lock,
            showicon: true,
            validator: (value) {
              return value!.isEmpty ? "Please Enter Your Password" : null;
            },
            textEditingController: passwordController,
          ),
          AppSizes.gapH48,
          AppButton(
            color: Colors.deepPurple,
            width: 1.sw,
            title: 'Sign In',
            func: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthenticationCubit>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
