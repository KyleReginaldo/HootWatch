// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/constants/constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Widget? suffix;
  final bool? isObscure;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final GlobalKey<FormState>? formKey;
  final double? radius;
  final Color? borderColor;
  final Color? bgColor;
  final bool? lastTextField;
  final int? maxLength;
  final TextInputAction? action;
  final String? initialValue;
  final Color? fontColor;
  final double? width;
  const CustomTextField({
    Key? key,
    this.controller,
    required this.hint,
    this.suffix,
    this.isObscure,
    this.prefix,
    this.validator,
    this.keyboard,
    this.formKey,
    this.radius,
    this.borderColor,
    this.bgColor,
    this.lastTextField,
    this.maxLength,
    this.action,
    this.initialValue,
    this.fontColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return SizedBox(
      width: width,
      child: TextFormField(
        key: formKey,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textInputAction: action,
        keyboardType: keyboard,
        maxLength: maxLength,
        obscureText: isObscure ?? false,
        validator: validator,
        onEditingComplete: () {
          if (lastTextField ?? false) {
            node.unfocus();
          }
          {
            node.nextFocus();
          }
        },
        style: TextStyle(color: fontColor),
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffix,
          prefixIcon: prefix,
          counterText: '',
          fillColor: bgColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Theme.of(context).secondaryHeaderColor,
            ),
            borderRadius: BorderRadius.circular(radius ?? kMinRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Theme.of(context).secondaryHeaderColor,
            ),
            borderRadius: BorderRadius.circular(radius ?? kMinRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Theme.of(context).secondaryHeaderColor,
            ),
            borderRadius: BorderRadius.circular(radius ?? kMinRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(radius ?? kMinRadius),
          ),
          hintStyle: const TextStyle(
            color: Color(0xffC0C0C0),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
