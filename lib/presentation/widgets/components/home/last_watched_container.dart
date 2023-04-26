import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/presentation/cubits/lastWatched/last_watched_cubit.dart';
import '../../../../core/constants/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../customs/ani_container.dart';
import '../../customs/text.dart';

class LastWatchedContainer extends StatelessWidget {
  const LastWatchedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastWatchedCubit, LastWatchedState>(
      builder: (context, state) {
        print(state);
        if (state is LastWatchedLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.animes.isNotEmpty) SizedBox(height: 2.h),
              if (state.animes.isNotEmpty)
                CustomText(
                  'Last Watched',
                  size: 18.sp,
                  weight: FontWeight.bold,
                  color: AppTheme.greyLight3,
                ),
              if (state.animes.isNotEmpty) SizedBox(height: 0.5.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.animes.map((e) {
                    return CustomAniContainer(
                      image: e.image,
                      padding: EdgeInsets.only(right: 1.h),
                      onTap: () {
                        AutoRouter.of(context).push(
                          StreamingRoute(
                            animeId: e.animeId,
                            episodeId: e.episodeId,
                            image: e.image,
                            episodes: e.episodes,
                            willContinueAt: e.continueAt,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else if (state is LastWatchedLoading) {
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.greyDark1,
                          borderRadius: BorderRadius.circular(kMinRadius),
                        ),
                        padding: EdgeInsets.all(2.h),
                        width: 32.w,
                        height: 20.h,
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
