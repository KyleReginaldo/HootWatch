// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../../../core/constants/constant.dart';

class CustomAniContainer extends StatelessWidget {
  final String image;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  const CustomAniContainer({
    Key? key,
    required this.image,
    required this.title,
    this.color,
    this.onTap,
    this.padding,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kMinRadius),
        ),
        clipBehavior: Clip.hardEdge,
        width: 32.w,
        height: 20.h,
        child: CachedNetworkImage(
          imageUrl: image,
          height: 25.h,
          width: 40.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
