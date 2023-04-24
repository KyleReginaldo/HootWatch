// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';

import '../../../../core/constants/constant.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? icon;
  const CustomIconButton({
    Key? key,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: 5.h,
        width: 5.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(kMinRadius),
          border: Border.all(
            color: AppTheme.redDark1,
          ),
        ),
        child: icon,
      ),
    );
  }
}
