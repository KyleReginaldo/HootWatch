// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import '../text.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? bgColor;
  final Color? iconColor;
  final Widget icon;
  final Color? textColor;
  final double? width;
  final double? height;
  const CustomElevatedIconButton({
    Key? key,
    this.onTap,
    required this.title,
    this.bgColor,
    this.iconColor,
    required this.icon,
    this.textColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: icon,
      label: CustomText(
        title,
        color: textColor ?? AppTheme.white,
      ),
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(
          iconColor ?? AppTheme.systemRed,
        ),
        backgroundColor: MaterialStatePropertyAll(
          bgColor ?? AppTheme.black,
        ),
      ),
    );
  }
}
