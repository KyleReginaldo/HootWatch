import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import 'package:yoyo/presentation/widgets/customs/textfield.dart';

import '../../../core/constants/constant.dart';
import '../../../core/dtos/auth_dto.dart';
import '../../cubits/auth/authentication/authentication_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/MAIN_LOGO.png',
                  width: 8.h,
                  height: 8.h,
                  fit: BoxFit.fill,
                ).animate().fadeIn(),
                Image.asset(
                  'assets/image/WORD_LOGO.png',
                  width: 45.w,
                  height: 18.h,
                  fit: BoxFit.fill,
                ).animate().fadeIn(),
              ],
            ),
            CustomTextField(
              hint: 'Email',
              controller: email,
              fontColor: Theme.of(context).secondaryHeaderColor,
              width: 70.w,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Email";
                } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please Enter a Valid Email";
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),
            CustomTextField(
                hint: 'Password',
                fontColor: Theme.of(context).secondaryHeaderColor,
                width: 70.w,
                controller: password,
                validator: (value) {
                  String missings = "";
                  if (value!.isEmpty) {
                    missings += 'Please enter a password\n';
                  }
                  if (value.length < 8) {
                    missings += "Password has at least 8 characters\n";
                  }

                  if (!RegExp("(?=.*[a-z])").hasMatch(value)) {
                    missings +=
                        "Password must contain at least one lowercase letter\n";
                  }
                  if (!RegExp("(?=.*[A-Z])").hasMatch(value)) {
                    missings +=
                        "Password must contain at least one uppercase letter\n";
                  }
                  if (!RegExp((r'\d')).hasMatch(value)) {
                    missings += "Password must contain at least one digit\n";
                  }

                  //if there is password input errors return error string
                  if (missings != "") {
                    return missings;
                  }
                  return null;
                }),
            SizedBox(height: 2.h),
            BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
                if (state is SignUpError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: CustomText(state.msg)));
                } else if (state is SignedUp) {
                  if (AutoRouter.of(context).canPop()) {
                    Future.delayed(const Duration(seconds: 1), () {
                      AutoRouter.of(context).pop();
                    });
                  }
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: state is SigningUp
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthenticationCubit>().onSignup(
                                    authDto: AuthDto(
                                  email: email.text,
                                  password: password.text,
                                ));
                          }
                        },
                  child: AnimatedContainer(
                    width: state is SigningUp ? 6.h : 70.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(
                        state is SigningUp ? 100 : kMinRadius,
                      ),
                    ),
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                    child: state is SigningUp
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const CustomText(
                            'Signup',
                            color: Colors.white,
                          ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                  child: CustomText(
                    'Login',
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
