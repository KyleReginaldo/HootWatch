// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';

import '../../../../core/constants/constant.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? bgColor;
  final double? radius;
  const CustomIconButton({
    Key? key,
    this.onTap,
    this.icon,
    this.bgColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: 5.h,
        width: 5.h,
        decoration: BoxDecoration(
          color: bgColor != null
              ? bgColor?.withOpacity(0.3)
              : Theme.of(context).primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(radius ?? kMinRadius),
          border: Border.all(
            color: bgColor ?? AppTheme.redDark1,
          ),
        ),
        child: icon,
      ),
    );
  }
}
