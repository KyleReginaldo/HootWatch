import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/utils/custom_functions.dart';

import '../../../../core/router/custom_router.dart';
import '../../../cubits/trending/trending_cubit.dart';
import '../../customs/text.dart';

class TrendingContainer extends StatelessWidget {
  const TrendingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(
      builder: (context, state) {
        if (state is TrendingLoaded) {
          return CarouselSlider(
            items: state.trending.results.map((e) {
              return GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(
                    InfoRoute(id: e.id),
                  );
                },
                child: Container(
                  width: 100.w - 2.h,
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    image: DecorationImage(
                      image: NetworkImage(e.cover),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(kMinRadius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        e.title.userPreferred,
                        size: 16.sp,
                        weight: FontWeight.w600,
                      ).animate().fadeIn(duration: 500.ms),
                      CustomText(
                        CustomFunctions.removeTags(e.description),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).animate().fadeIn(duration: 1000.ms),
                      const Divider(),
                      CustomText('${e.releaseDate} | E${e.totalEpisodes}'),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 25.h,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              // scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
          );
        } else if (state is TrendingLoading) {
          return Shimmer.fromColors(
            highlightColor: kLightGrey1Color,
            baseColor: kLightGrey2Color,
            child: Container(
              decoration: BoxDecoration(
                color: kLightGrey2Color,
                borderRadius: BorderRadius.circular(kMinRadius),
              ),
              padding: EdgeInsets.all(2.h),
              height: 25.h,
              width: 100.w - 2,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
