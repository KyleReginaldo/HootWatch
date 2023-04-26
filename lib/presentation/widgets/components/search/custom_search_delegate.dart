import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yoyo/presentation/blocs/search/search_bloc.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/router/custom_router.dart';
import '../../../../core/utils/custom_functions.dart';
import '../../../../domain/entity/search_entity.dart';
import '../../customs/text.dart';

class SearchPageDelegate extends SearchDelegate<SearchEntity> {
  final Bloc<SearchEvent, SearchState> searchBloc;

  SearchPageDelegate({required this.searchBloc});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(Search(query: query));
    return BlocBuilder(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchLoaded) {
          return ListView(
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
                              CustomFunctions.removeTags(e.description ?? ''),
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
          return ListView(
            children: List.generate(
              6,
              (index) => Shimmer.fromColors(
                highlightColor: kDarkGrey1Color,
                baseColor: kDarkGrey2Color,
                child: Container(
                  margin: EdgeInsets.all(0.5.h),
                  height: 16.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: kDarkGrey2Color,
                    borderRadius: BorderRadius.circular(kMinRadius),
                  ),
                ),
              ),
            ),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
