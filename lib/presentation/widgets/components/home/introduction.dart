// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../customs/text.dart';

class Introduction extends StatelessWidget {
  final Widget search;
  const Introduction({
    Key? key,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32.h,
      width: 100.w,
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     kPrimaryColor,
          //     kLightBlue2Color,
          //     kBlackColor,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          search,
          const Spacer(),
          CustomText(
            'What you are\nlooking for?',
            color: const Color(0xFF9fa1a2),
            size: 24.sp,
            textAlign: TextAlign.center,
            weight: FontWeight.w600,
          ),
          CustomText(
            'Find your favorite Anime Between more\nThan 10,000 Anime',
            color: const Color(0xFF9fa1a2),
            size: 14.sp,
            textAlign: TextAlign.center,
            weight: FontWeight.w600,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
