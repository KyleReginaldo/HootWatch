// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:duration/duration.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/domain/entity/favorite_entity.dart';
import 'package:yoyo/presentation/cubits/favorite/is_favorite_cubit.dart';
import 'package:yoyo/presentation/cubits/state.dart';
import 'package:yoyo/presentation/widgets/customs/button/elevated_icon_button.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';

import '../../../core/constants/constant.dart';
import '../../../core/router/custom_router.dart';
import '../../cubits/favorite/favorite_cubit.dart';
import '../../widgets/components/info/episode_container.dart';
import '../../widgets/customs/icons/icon_button.dart';

class InfoScreen extends StatefulWidget {
  final String id;
  final int? tab;
  final Color? color;
  const InfoScreen({
    Key? key,
    required this.id,
    this.tab,
    this.color,
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
    context.read<IsFavoriteCubit>().isFavorite(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          animeId: widget.id,
        );
    context.read<LastwatchCubit>().onCheckLastWatch(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          animeId: widget.id,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final selectedTab = context.select((InfoswitchCubit sw) => sw.state);
      final isFavorite = context.select((IsFavoriteCubit ifs) => ifs.state);
      final lastwatch = context.select((LastwatchCubit lw) => lw.state);
      return WillPopScope(
        onWillPop: () async {
          context.read<LastWatchedCubit>().onFetchLastWatched(
              userId: FirebaseAuth.instance.currentUser?.uid ?? "");
          return true;
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: CustomIconButton(
              onTap: () {
                AutoRouter.of(context).pop();
              },
              glow: true,
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppTheme.white,
              ),
            ),
          ),
          body: BlocConsumer<InfoCubit, InfoState>(
            listener: (context, state) {
              if (state is InfoLoaded) {
                context.read<EpisodesCubit>().addEpisodes(state.Info.episodes);
              } else if (state is InfoError) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const CustomText('Error'),
                        content: const CustomText(
                          'Server down please comeback later.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              AutoRouter.of(context).popUntilRoot();
                            },
                            child: const CustomText('back'),
                          ),
                          TextButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const CustomText('exit'),
                          ),
                        ],
                      );
                    });
              }
            },
            builder: (context, state) {
              if (state is InfoLoaded) {
                final info = state.Info;
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: state.Info.cover,
                          fit: BoxFit.cover,
                          height: 45.h,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.minRadius),
                                  child: CachedNetworkImage(
                                    imageUrl: info.image,
                                    height: 16.h,
                                    width: 24.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                CustomText(
                                  info.title.english ??
                                      info.title.userPreferred ??
                                      info.title.romaji,
                                  size: 20.sp,
                                  weight: FontWeight.w600,
                                ),
                              ],
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
                          CustomElevatedIconButton(
                            onTap: () {
                              final favorite = FavoriteEntity(
                                id: info.id,
                                malId: info.malId ?? 0,
                                image: info.image,
                                title: info.title,
                                uploadedAt: DateTime.now().toString(),
                                color: info.color,
                              );
                              if (isFavorite) {
                                context
                                    .read<FavoriteCubit>()
                                    .onRemoveFavorite(
                                      userId: FirebaseAuth
                                              .instance.currentUser?.uid ??
                                          "",
                                      animeId: info.id,
                                    )
                                    .then((value) async {
                                  context.read<IsFavoriteCubit>().isFavorite(
                                        userId: value,
                                        animeId: widget.id,
                                      );
                                });
                              } else {
                                context
                                    .read<FavoriteCubit>()
                                    .onAddFavorite(
                                      userId: FirebaseAuth
                                              .instance.currentUser?.uid ??
                                          "",
                                      favorite: favorite,
                                    )
                                    .then((value) async {
                                  context.read<IsFavoriteCubit>().isFavorite(
                                        userId: value,
                                        animeId: widget.id,
                                      );
                                });
                              }
                            },
                            title: isFavorite
                                ? 'Remove to Favorite'
                                : 'Add to Favorites',
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            bgColor: AppTheme.greyDark2,
                          ),
                          const CustomText('Genre'),
                          Wrap(
                            children: info.genres.map((genre) {
                              return CustomText(
                                  "$genre${genre == info.genres.last ? "" : " · "}");
                            }).toList(),
                          ),
                          GestureDetector(
                            onTap: lastwatch != null
                                ? () async {
                                    var result =
                                        await AutoRouter.of(context).push<bool>(
                                      StreamingRoute(
                                        animeId: lastwatch.animeId,
                                        episodeId: lastwatch.episodeId,
                                        image: lastwatch.image,
                                        episodes: lastwatch.episodes,
                                        willContinueAt: lastwatch.continueAt,
                                        title: lastwatch.title,
                                        episodeNumber: lastwatch.episodeNumber,
                                      ),
                                    );
                                    if (context.mounted && (result as bool)) {
                                      context
                                          .read<LastwatchCubit>()
                                          .onCheckLastWatch(
                                            userId: FirebaseAuth.instance
                                                    .currentUser?.uid ??
                                                '',
                                            animeId: widget.id,
                                          );
                                    }
                                  }
                                : () async {
                                    var result =
                                        await AutoRouter.of(context).push<bool>(
                                      StreamingRoute(
                                        episodeId: info.episodes.first.id,
                                        episodes: info.episodes,
                                        image: info.episodes.first.image,
                                        animeId: widget.id,
                                        title: info.title.english ??
                                            info.title.userPreferred ??
                                            info.title.romaji ??
                                            '${info.episodes.first.number}',
                                        episodeNumber:
                                            info.episodes.first.number,
                                      ),
                                    );
                                    if (context.mounted && (result as bool)) {
                                      context
                                          .read<LastwatchCubit>()
                                          .onCheckLastWatch(
                                            userId: FirebaseAuth.instance
                                                    .currentUser?.uid ??
                                                '',
                                            animeId: widget.id,
                                          );
                                    }
                                  },
                            child: Container(
                              height: 6.h,
                              width: 100.w,
                              margin: EdgeInsets.only(top: 1.h),
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.minRadius),
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
                                    lastwatch != null
                                        ? 'Continue at ${printDuration(CustomFunctions.parseDuration(lastwatch.continueAt.willContinueAt))} Ep.${lastwatch.episodeNumber}'
                                        : 'Play',
                                    color: AppTheme.greyDark1,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (info.description != null) SizedBox(height: 1.h),
                          if (info.description != null)
                            const CustomText('Synopsis'),
                          if (info.description != null)
                            ReadMoreText(
                              CustomFunctions.removeTags(info.description!),
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
                              children: info.episodes.toSet().map((episode) {
                                return EpisodeContainer(
                                  episode: episode,
                                  onTap: () {
                                    AutoRouter.of(context).push(
                                      StreamingRoute(
                                        episodeId: episode.id,
                                        episodes: info.episodes,
                                        image: info.image,
                                        animeId: info.id,
                                        title: info.title.english ??
                                            info.title.userPreferred ??
                                            info.title.romaji ??
                                            '${episode.number}',
                                        episodeNumber: episode.number,
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
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.minRadius),
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
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  }
}
