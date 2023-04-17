import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/dtos/auth_dto.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/presentation/cubits/auth/authentication/authentication_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import 'package:yoyo/presentation/widgets/customs/textfield.dart';

import '../../../core/constants/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              controller: email,
              hint: 'Email',
              fontColor: Theme.of(context).secondaryHeaderColor,
              width: 70.w,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'please provide an email';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),
            CustomTextField(
              controller: password,
              hint: 'Password',
              fontColor: Theme.of(context).secondaryHeaderColor,
              width: 70.w,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),
            BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
                if (state is LogInError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: CustomText(state.msg)));
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: state is LoggingIn
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthenticationCubit>().onLogin(
                                    authDto: AuthDto(
                                  email: email.text,
                                  password: password.text,
                                ));
                          }
                        },
                  child: AnimatedContainer(
                    width: state is LoggingIn ? 6.h : 70.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(
                        state is LoggingIn ? 100 : kMinRadius,
                      ),
                    ),
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                    child: state is LoggingIn
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const CustomText(
                            'Login',
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
                const CustomText('Don\'t have an account? '),
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const SignupRoute());
                  },
                  child: CustomText(
                    'Signup',
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
