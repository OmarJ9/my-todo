import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/utils/validators.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextfield(
            hint: 'Full Name',
            icon: Icons.person,
            keyboardtype: TextInputType.name,
            validator: (value) {
              return value!.length < 3 ? 'Invalid Name' : null;
            },
            textEditingController: nameController,
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: 'Email Address',
            icon: Icons.email,
            keyboardtype: TextInputType.emailAddress,
            validator: (value) {
              return !Validators.isValidEmail(value!)
                  ? 'Enter a valid email'
                  : null;
            },
            textEditingController: emailController,
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: 'Password',
            icon: Icons.password,
            obscure: true,
            keyboardtype: TextInputType.text,
            validator: (value) {
              return value!.length < 6 ? "Enter min. 6 characters" : null;
            },
            textEditingController: passwordController,
          ),
          AppSizes.gapH48,
          Align(
            alignment: Alignment.center,
            child: AppButton(
              color: Colors.deepPurple,
              width: 200.w,
              title: 'Sign Up',
              func: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthenticationCubit>().register(
                        username: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
