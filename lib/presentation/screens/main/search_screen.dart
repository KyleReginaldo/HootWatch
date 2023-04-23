import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/presentation/cubits/search/search_cubit.dart';

import '../../../core/router/custom_router.dart';
import '../../widgets/components/home/search_bar.dart';
import '../../widgets/customs/text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context
        .read<SearchCubit>()
        .onSeachAnime(query: searchController.text, limit: 0, canLoad: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            SearchBar(
              width: 100.w,
              controller: searchController,
              bgColor: kDarkGrey2Color,
              onChange: (val) {
                context
                    .read<SearchCubit>()
                    .onSeachAnime(query: val, limit: 0, canLoad: true);
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                print(state);
                if (state is SearchLoaded) {
                  return Column(
                    children: state.search.results.map((e) {
                      return GestureDetector(
                        onTap: () {
                          AutoRouter.of(context).push(InfoRoute(id: e.id));
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: e.image,
                                height: 16.h,
                                width: 25.w,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      e.title.userPreferred ??
                                          e.title.english ??
                                          e.title.native ??
                                          e.title.romaji ??
                                          '',
                                      size: 16.sp,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ).animate().fadeIn(duration: 500.ms),
                                    CustomText(
                                      CustomFunctions.removeTags(
                                          e.description ?? ''),
                                      size: 14.sp,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                    ).animate().fadeIn(duration: 500.ms),
                                  ],
                                ),
                              ),
                              SizedBox(width: 1.w),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is SearchLoading) {
                  return LinearProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                } else if (state is SearchError) {
                  return CustomText(
                    'Sorry, we could not find the anime you are looking for. ',
                    size: 18.sp,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w600,
                    color: kDarkGrey1Color,
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
