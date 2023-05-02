import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/presentation/cubits/random/random_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/button/elevated_icon_button.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import '../../../../core/constants/app_theme.dart';

class RandomContainer extends StatelessWidget {
  const RandomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomCubit, RandomState>(
      builder: (context, state) {
        if (state is RandomLoaded) {
          final random = state.random;
          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: random.image,
                width: 100.w,
                height: 45.h,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 16.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.black,
                        AppTheme.black,
                        AppTheme.black,
                        AppTheme.black.withOpacity(0.9),
                        AppTheme.black.withOpacity(0.8),
                        AppTheme.black.withOpacity(0.6),
                        AppTheme.black.withOpacity(0.3),
                        AppTheme.black.withOpacity(0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.black.withOpacity(0),
                        AppTheme.black.withOpacity(0.1),
                        AppTheme.black.withOpacity(0.2),
                        AppTheme.black.withOpacity(0.3),
                        AppTheme.black.withOpacity(0.4),
                        AppTheme.black.withOpacity(0.5),
                        AppTheme.black.withOpacity(0.7),
                        AppTheme.black.withOpacity(0.8),
                        AppTheme.black.withOpacity(0.9),
                        AppTheme.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        random.title.english ??
                            random.title.userPreferred ??
                            random.title.romaji,
                        size: 20.sp,
                        weight: FontWeight.w900,
                        textAlign: TextAlign.center,
                      ),
                      Wrap(
                        children: random.genres.map((genre) {
                          return CustomText(
                              "$genre${genre == random.genres.last ? "" : " · "}");
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedIconButton(
                            title: 'My List',
                            onTap: () {},
                            icon: const Icon(Icons.add_rounded),
                          ),
                          SizedBox(width: 1.h),
                          CustomElevatedIconButton(
                            title: 'Info',
                            onTap: () {
                              AutoRouter.of(context).push(InfoRoute(
                                id: random.id,
                                color: Color(CustomFunctions.convertHexToInt(
                                  random.color ?? '#FE0202',
                                )),
                              ));
                            },
                            icon: const Icon(Icons.info_outline_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is RandomLoading) {
          return FadeShimmer(
            height: 60.h,
            width: 100.w,
            highlightColor: AppTheme.black,
            baseColor: AppTheme.greyDark2,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
