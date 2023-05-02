import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/presentation/cubits/lastWatched/last_watched_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/custom_router.dart';
import '../../../../core/utils/custom_functions.dart';
import '../../customs/text.dart';

class LastWatchedContainer extends StatelessWidget {
  const LastWatchedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastWatchedCubit, LastWatchedState>(
      builder: (context, state) {
        if (state is LastWatchedLoaded) {
          final animes = state.animes;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (animes.isNotEmpty) SizedBox(height: 2.h),
              if (animes.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: CustomText(
                    'Continue to watch',
                    size: 16.sp,
                    weight: FontWeight.bold,
                    color: AppTheme.greyLight3,
                  ),
                ),
              if (state.animes.isNotEmpty) SizedBox(height: 0.5.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: animes.map((anime) {
                    return SizedBox(
                      width: 42.w,
                      height: 20.h,
                      child: Column(
                        children: [
                          Stack(
                            fit: StackFit.passthrough,
                            clipBehavior: Clip.none,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).push(
                                    StreamingRoute(
                                      animeId: anime.animeId,
                                      episodeId: anime.episodeId,
                                      image: anime.image,
                                      episodes: anime.episodes,
                                      willContinueAt: anime.continueAt,
                                      title: anime.title,
                                      episodeNumber: anime.episodeNumber,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 1.h),
                                  height: 16.h,
                                  width: 42.w,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: CachedNetworkImage(
                                    height: 16.h,
                                    width: 42.w,
                                    imageUrl: anime.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: LinearPercentIndicator(
                                  animation: true,
                                  backgroundColor: AppTheme.greyLight2,
                                  restartAnimation: true,
                                  animateFromLastPercent: true,
                                  lineHeight: 5,
                                  clipLinearGradient: true,
                                  progressColor: Theme.of(context).primaryColor,
                                  percent:
                                      CustomFunctions.getLastWatchedDuration(
                                    durationS: CustomFunctions.parseDuration(
                                        anime.continueAt.willContinueAt),
                                    durationL: CustomFunctions.parseDuration(
                                        anime.duration),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomText(
                            anime.title,
                            size: 13.sp,
                            weight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else if (state is LastWatchedLoading) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: EdgeInsets.all(1.h),
                        child: FadeShimmer(
                          width: 45.w,
                          height: 16.h,
                          highlightColor: AppTheme.black,
                          radius: 8,
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
