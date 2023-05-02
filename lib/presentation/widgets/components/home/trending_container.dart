import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo/core/constants/svg_icon.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/presentation/cubits/common/carousel_title_cubit.dart';
import 'package:yoyo/presentation/cubits/common/color_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/button/elevated_icon_button.dart';

import '../../../cubits/trending/trending_cubit.dart';

class TrendingContainer extends StatelessWidget {
  const TrendingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bgColor = context.select((ColorCubit clr) => clr.state);
        return BlocConsumer<TrendingCubit, TrendingState>(
          listener: (context, state) {
            if (state is TrendingLoaded) {
              context.read<CarouselTitleCubit>().changeTitle(
                  state.trending.results.first.title.english ??
                      state.trending.results.first.title.userPreferred ??
                      state.trending.results.first.title.romaji ??
                      state.trending.results.first.title.native ??
                      '');
            }
          },
          builder: (context, state) {
            if (state is TrendingLoaded) {
              return Container(
                padding: EdgeInsets.only(top: 10.h),
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bgColor.withOpacity(0.3),
                      bgColor.withOpacity(0.4),
                      bgColor.withOpacity(0.5),
                      bgColor.withOpacity(0.6),
                      bgColor.withOpacity(0.5),
                      bgColor.withOpacity(0.4),
                      bgColor.withOpacity(0.3),
                      bgColor.withOpacity(0.2),
                      bgColor.withOpacity(0.1),
                      bgColor.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CarouselSlider(
                  items: state.trending.results.map((e) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.h),
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: e.image,
                              width: 100.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              height: 20.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.black.withOpacity(0),
                                    AppTheme.black.withOpacity(0.1),
                                    AppTheme.black.withOpacity(0.2),
                                    AppTheme.black.withOpacity(0.3),
                                    AppTheme.black.withOpacity(0.4),
                                    AppTheme.black.withOpacity(0.5),
                                    AppTheme.black.withOpacity(0.6),
                                    AppTheme.black.withOpacity(0.7),
                                    AppTheme.black.withOpacity(0.8),
                                    AppTheme.black.withOpacity(0.9),
                                    AppTheme.black,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomElevatedIconButton(
                                    title: 'Bookmark',
                                    icon: SvgPicture.asset(
                                      SvgIcon.add,
                                      color: AppTheme.white,
                                    ),
                                    bgColor: AppTheme.greyDark3,
                                  ),
                                  SizedBox(width: 4.w),
                                  CustomElevatedIconButton(
                                    title: 'Info',
                                    icon: SvgPicture.asset(
                                      SvgIcon.info,
                                      color: AppTheme.white,
                                    ),
                                    bgColor: AppTheme.greyDark3,
                                    onTap: () {
                                      AutoRouter.of(context)
                                          .push(InfoRoute(id: e.id));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 40.h,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    disableCenter: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      context.read<ColorCubit>().pickColor(
                            Color(
                              CustomFunctions.convertHexToInt(
                                state.trending.results[index].color ??
                                    '#FE0202',
                              ),
                            ),
                          );
                    },
                  ),
                ),
              );
            } else if (state is TrendingLoading) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: EdgeInsets.all(1.h),
                            child: FadeShimmer(
                              width: 100.w,
                              height: 25.h,
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
      },
    );
  }
}
