import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';
import '../../../../core/constants/constant.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yoyo/core/router/custom_router.dart';

import '../../../../core/utils/custom_functions.dart';
import '../../../cubits/recent/recent_cubit.dart';
import '../../customs/ani_container.dart';
import '../../customs/text.dart';

class RecentContainer extends StatelessWidget {
  const RecentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentCubit, RecentState>(
      builder: (context, state) {
        if (state is RecentLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              CustomText(
                'Recent',
                size: 18.sp,
                weight: FontWeight.bold,
                color: AppTheme.greyLight3,
              ),
              SizedBox(height: 0.5.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.recent.results.map((e) {
                    return CustomAniContainer(
                      image: e.image,
                      subtitle: 'Episode ${e.episodeNumber}',
                      padding: EdgeInsets.only(right: 1.h),
                      title: e.title.userPreferred ?? 'No Title',
                      color: Color(CustomFunctions.convertHexToInt(
                        e.color ?? '#810CA8',
                      )),
                      onTap: () {
                        AutoRouter.of(context).push(InfoRoute(id: e.id));
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else if (state is RecentLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 1.h),
                      child: Shimmer.fromColors(
                        highlightColor: kDarkGrey1Color,
                        baseColor: kDarkGrey2Color,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kDarkGrey2Color,
                            borderRadius: BorderRadius.circular(kMinRadius),
                          ),
                          padding: EdgeInsets.all(2.h),
                          width: 32.w,
                          height: 20.h,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
