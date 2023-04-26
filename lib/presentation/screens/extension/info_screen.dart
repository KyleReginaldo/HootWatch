// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/presentation/cubits/common/episodes/episodes_cubit.dart';
import 'package:yoyo/presentation/cubits/common/infoswitch_cubit.dart';
import 'package:yoyo/presentation/cubits/info/info_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import 'package:readmore/readmore.dart';

import '../../../core/constants/constant.dart';
import '../../../core/router/custom_router.dart';
import '../../widgets/components/info/episode_container.dart';
import '../../widgets/customs/icons/icon_button.dart';

class InfoScreen extends StatefulWidget {
  final String id;
  final int? tab;
  const InfoScreen({
    Key? key,
    required this.id,
    this.tab,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    context.read<InfoCubit>().onFetchAnimeInfo(widget.id);
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    context.read<InfoswitchCubit>().switchTab(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final selectedTab = context.select((InfoswitchCubit sw) => sw.state);
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: CustomIconButton(
            onTap: () {
              AutoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: kWhiteColor,
            ),
          ),
        ),
        body: BlocConsumer<InfoCubit, InfoState>(
          listener: (context, state) {
            if (state is InfoLoaded) {
              context.read<EpisodesCubit>().addEpisodes(state.Info.episodes);
            }
          },
          builder: (context, state) {
            if (state is InfoLoaded) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: state.Info.cover,
                        fit: BoxFit.cover,
                        height: 35.h,
                        width: 100.w,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 1.h, top: 4.h),
                          alignment: Alignment.bottomLeft,
                          width: 100.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.black.withOpacity(0),
                                AppTheme.black.withOpacity(0.2),
                                AppTheme.black,
                                AppTheme.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: CustomText(
                            state.Info.title.english ??
                                state.Info.title.userPreferred ??
                                state.Info.title.romaji,
                            size: 20.sp,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        const CustomText('Genre'),
                        Wrap(
                          children: state.Info.genres.map((genre) {
                            return CustomText(
                                "$genre ${genre == state.Info.genres.last ? "" : "·"}");
                          }).toList(),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 6.h,
                            width: 100.w,
                            margin: EdgeInsets.only(top: 1.h),
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(kMinRadius),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.play_arrow,
                                  color: AppTheme.greyDark1,
                                ),
                                SizedBox(width: 2.w),
                                CustomText(
                                  'Play',
                                  color: AppTheme.greyDark1,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (state.Info.description != null)
                          SizedBox(height: 1.h),
                        if (state.Info.description != null)
                          const CustomText('Synopsis'),
                        if (state.Info.description != null)
                          ReadMoreText(
                            CustomFunctions.removeTags(state.Info.description!),
                            trimLines: 3,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            moreStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.white,
                            ),
                            lessStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    tabs: const [
                      Tab(
                        text: 'Episodes',
                      ),
                      Tab(
                        text: 'Recommendations',
                      )
                    ],
                    onTap: (index) {
                      tabController.animateTo(index);
                      context.read<InfoswitchCubit>().switchTab(index);
                    },
                  ),
                  IndexedStack(
                    index: selectedTab,
                    children: [
                      Visibility(
                        maintainState: true,
                        visible: selectedTab == 0,
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: Column(
                            children: state.Info.episodes.toSet().map((e) {
                              return EpisodeContainer(
                                episode: e,
                                onTap: () {
                                  AutoRouter.of(context).push(
                                    StreamingRoute(
                                      episodeId: e.id,
                                      episodes: state.Info.episodes,
                                      image: state.Info.image,
                                      animeId: state.Info.id,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Visibility(
                        maintainState: true,
                        visible: selectedTab == 1,
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: Wrap(
                            spacing: 2.h,
                            runSpacing: 2.h,
                            alignment: WrapAlignment.start,
                            children: state.Info.recommendations.map((e) {
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<InfoCubit>()
                                      .onFetchAnimeInfo(e.id.toString());
                                },
                                child: Container(
                                  height: 24.h,
                                  width: 45.w,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kMinRadius),
                                    color: Color(
                                      CustomFunctions.convertHexToInt(
                                        e.color ?? '#FE0202',
                                      ),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: e.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is InfoLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return const SizedBox.shrink();
          },
        ),
      );
    });
  }
}
