import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_functions.dart';
import '../../../cubits/upcoming/upcoming_cubit.dart';
import '../../customs/ani_container.dart';
import '../../customs/text.dart';

class UpcomingContainer extends StatelessWidget {
  const UpcomingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingCubit, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.upcoming.results.isNotEmpty) SizedBox(height: 2.h),
              if (state.upcoming.results.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: CustomText(
                    'Upcoming',
                    size: 16.sp,
                    weight: FontWeight.bold,
                    color: AppTheme.greyLight3,
                  ),
                ),
              if (state.upcoming.results.isNotEmpty) SizedBox(height: 0.5.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.upcoming.results.map((e) {
                    return CustomAniContainer(
                      image: e.image,
                      padding: EdgeInsets.only(left: 1.h),
                      subtitle: 'Episode ${e.episode}',
                      color: Color(CustomFunctions.convertHexToInt(
                        '#000000',
                      )),
                      onTap: () {},
                      title: e.title.english ??
                          e.title.userPreferred ??
                          e.title.romaji,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else if (state is UpcomingLoading) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: EdgeInsets.all(1.h),
                        child: FadeShimmer(
                          width: 32.w,
                          height: 20.h,
                          radius: 8,
                          highlightColor: AppTheme.black,
                          baseColor: AppTheme.greyDark2,
                        ),
                      )),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
