// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:auto_route/auto_route.dart';

import 'package:extended_betterplayer/better_player.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/domain/entity/info_entity.dart';
import 'package:yoyo/presentation/cubits/common/fullscreen_cubit.dart';
import 'package:yoyo/presentation/cubits/common/playing_cubit.dart';
import 'package:yoyo/presentation/cubits/streamlink/streamlink_cubit.dart';
import 'package:yoyo/presentation/widgets/components/info/episode_container.dart';
import 'package:yoyo/presentation/widgets/customs/icons/icon_button.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import '../../../domain/entity/last_watched_entity.dart';
import '../../cubits/lastWatched/last_watched_cubit.dart';
import '../../cubits/streamlink/lastwatch_cubit.dart';

class StreamingScreen extends StatefulWidget {
  final String animeId;
  final String episodeId;
  final String image;
  final List<EpisodeEntity> episodes;
  final ContinueAtEntity? willContinueAt;
  final String title;
  final int? episodeNumber;
  const StreamingScreen({
    Key? key,
    required this.animeId,
    required this.episodeId,
    required this.image,
    required this.episodes,
    this.willContinueAt,
    required this.title,
    this.episodeNumber,
  }) : super(key: key);

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  late BetterPlayerController betterController;
  late LastWatchedEntity lastWatched;

  @override
  void initState() {
    context.read<StreamlinkCubit>().onFetchStreamLinks(
          widget.episodeId,
          episodeNumber: widget.episodeNumber,
        );
    context.read<PlayingCubit>().setId(widget.episodeId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isFullscreen = context.select((FullscreenCubit fs) => fs.state);
        final givenId = context.select((PlayingCubit pl) => pl.state);
        return WillPopScope(
          onWillPop: () async {
            context.read<LastWatchedCubit>().onFetchLastWatched(
                  userId: FirebaseAuth.instance.currentUser?.uid ?? "",
                  info: lastWatched,
                );
            context.read<LastwatchCubit>().onCheckLastWatch(
                  userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                  animeId: widget.animeId,
                );
            return true;
          },
          child: Scaffold(
            appBar: isFullscreen
                ? null
                : AppBar(
                    title: DefaultTextStyle(
                      style: const TextStyle().copyWith(
                        fontSize: 14.sp,
                        fontFamily: 'NetflixSans',
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            widget.title,
                            speed: const Duration(milliseconds: 60),
                          ),
                        ],
                      ),
                    ),
                    leading: CustomIconButton(
                      onTap: () async {
                        context
                            .read<LastWatchedCubit>()
                            .onSaveLastWatched(
                              userId:
                                  FirebaseAuth.instance.currentUser?.uid ?? '',
                              info: lastWatched,
                            )
                            .then((value) {
                          context.router.pop<bool>(true);
                        });
                      },
                      glow: true,
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<StreamlinkCubit, StreamlinkState>(
                  listener: (context, state) {
                    if (state is StreamlinkLoaded) {
                      betterController = BetterPlayerController(
                        betterPlayerPlaylistConfiguration:
                            const BetterPlayerPlaylistConfiguration(),
                        BetterPlayerConfiguration(
                          autoPlay: true,
                          startAt: widget.willContinueAt?.id == state.id
                              ? CustomFunctions.parseDuration(
                                  widget.willContinueAt?.willContinueAt ?? '0',
                                )
                              : null,
                          controlsConfiguration:
                              BetterPlayerControlsConfiguration(
                            playerTheme: Platform.isAndroid
                                ? BetterPlayerTheme.material
                                : Platform.isIOS
                                    ? BetterPlayerTheme.cupertino
                                    : null,
                          ),
                          eventListener: (BetterPlayerEvent event) {
                            if (event.betterPlayerEventType ==
                                BetterPlayerEventType.progress) {
                              if (betterController.isVideoInitialized() ??
                                  false) {
                                lastWatched = LastWatchedEntity(
                                  episodeId: state.id,
                                  episodes: widget.episodes,
                                  image: widget.image,
                                  animeId: widget.animeId,
                                  updatedAt: DateTime.now().toString(),
                                  title: widget.title,
                                  episodeNumber: state.episodeNumber,
                                  continueAt: ContinueAtEntity(
                                    id: state.id,
                                    willContinueAt: betterController
                                            .videoPlayerController
                                            ?.value
                                            .position
                                            .toString() ??
                                        const Duration().toString(),
                                  ),
                                  duration: betterController
                                          .videoPlayerController?.value.duration
                                          .toString() ??
                                      '',
                                );
                              }
                            }
                            if (event.betterPlayerEventType ==
                                BetterPlayerEventType.pause) {
                              context
                                  .read<LastWatchedCubit>()
                                  .onSaveLastWatched(
                                    userId: FirebaseAuth
                                            .instance.currentUser?.uid ??
                                        '',
                                    info: LastWatchedEntity(
                                      episodeId: state.id,
                                      episodes: widget.episodes,
                                      image: widget.image,
                                      animeId: widget.animeId,
                                      updatedAt: DateTime.now().toString(),
                                      title: widget.title,
                                      episodeNumber: state.episodeNumber,
                                      continueAt: ContinueAtEntity(
                                          id: state.id,
                                          willContinueAt: betterController
                                                  .videoPlayerController
                                                  ?.value
                                                  .position
                                                  .toString() ??
                                              const Duration().toString()),
                                      duration: betterController
                                              .videoPlayerController
                                              ?.value
                                              .duration
                                              .toString() ??
                                          '',
                                    ),
                                  );
                            }
                          },
                          autoDetectFullscreenDeviceOrientation: true,
                          fullScreenByDefault: true,
                        ),
                        betterPlayerDataSource: BetterPlayerDataSource(
                          BetterPlayerDataSourceType.network,
                          state.streamLink
                              .sources[state.streamLink.sources.length - 2].url,
                          resolutions: {
                            "360p": state.streamLink.sources[0].url,
                            "480p": state.streamLink.sources[1].url,
                            "720p": state.streamLink.sources[2].url,
                            "1080p": state.streamLink.sources[3].url,
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is StreamlinkLoaded) {
                      return BetterPlayer(
                        controller: betterController,
                      );
                    } else if (state is StreamlinkLoading) {
                      return FadeShimmer(
                        height: 27.h,
                        width: 100.w,
                        highlightColor: AppTheme.greyDark1,
                        baseColor: AppTheme.greyDark2,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                if (!isFullscreen)
                  Padding(
                    padding: AppDimens.paddingL1,
                    child: CustomText(
                      CustomFunctions.getPlayingEpisode(
                                  givenId ?? '', widget.episodes)
                              .title ??
                          'episode ${CustomFunctions.getPlayingEpisode(givenId ?? '', widget.episodes).number.toString()}',
                      size: 20.sp,
                      weight: FontWeight.bold,
                    ),
                  ),
                if (CustomFunctions.getPlayingEpisode(
                                givenId ?? '', widget.episodes)
                            .description !=
                        null &&
                    !isFullscreen)
                  Padding(
                    padding: AppDimens.paddingL1,
                    child: ReadMoreText(
                      CustomFunctions.removeTags(
                          CustomFunctions.getPlayingEpisode(
                                      givenId ?? '', widget.episodes)
                                  .description ??
                              ''),
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
                  ),
                if (!isFullscreen)
                  const Divider(
                    color: AppTheme.greyDark1,
                  ),
                if (!isFullscreen)
                  Padding(
                    padding: AppDimens.paddingL1,
                    child: const CustomText('EPISODES'),
                  ),
                //   BetterPlayerPlaylist(
                //   betterPlayerConfiguration: BetterPlayerConfiguration(),
                //   betterPlayerDataSourceList: widget.episodes.map((e) {
                //     return BetterPlayerDataSource.network(e.);
                //   }).toList(),
                //   betterPlayerPlaylistConfiguration:
                //       BetterPlayerPlaylistConfiguration(),
                // ),
                if (!isFullscreen)
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                      key: const PageStorageKey<String>('streamingPage'),
                      children: widget.episodes.map((e) {
                        return EpisodeContainer(
                          haveDesc: false,
                          onTap: e.id == givenId
                              ? null
                              : () {
                                  context
                                      .read<StreamlinkCubit>()
                                      .onFetchStreamLinks(e.id,
                                          episodeNumber: e.number);
                                  context.read<PlayingCubit>().setId(e.id);
                                },
                          episode: e,
                          subtitle: e.id == givenId ? 'Playing...' : null,
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
