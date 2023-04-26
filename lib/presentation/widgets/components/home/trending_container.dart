import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/presentation/widgets/customs/button/elevated_icon_button.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/router/custom_router.dart';
import '../../../cubits/trending/trending_cubit.dart';

class TrendingContainer extends StatelessWidget {
  const TrendingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(
      builder: (context, state) {
        if (state is TrendingLoaded) {
          return CarouselSlider(
            items: state.trending.results.map((e) {
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: e.image,
                    width: 100.w,
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
                            e.title.english ??
                                e.title.userPreferred ??
                                e.title.romaji,
                            size: 20.sp,
                            weight: FontWeight.w900,
                            textAlign: TextAlign.center,
                          ),
                          Wrap(
                            children: e.genres.map((genre) {
                              return CustomText(
                                  "$genre ${genre == e.genres.last ? "" : "·"}");
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
                                  AutoRouter.of(context)
                                      .push(InfoRoute(id: e.id));
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
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 60.h,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 16),
              enlargeCenterPage: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
          );
        } else if (state is TrendingLoading) {
          return Container(
            decoration: const BoxDecoration(
              color: AppTheme.black,
            ),
            padding: EdgeInsets.all(2.h),
            height: 60.h,
            width: 100.w,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
