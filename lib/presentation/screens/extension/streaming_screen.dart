// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/utils/custom_functions.dart';

import 'package:yoyo/domain/entity/info_entity.dart';
import 'package:yoyo/presentation/cubits/common/fullscreen_cubit.dart';
import 'package:yoyo/presentation/cubits/common/playing_cubit.dart';
import 'package:yoyo/presentation/cubits/streamlink/streamlink_cubit.dart';
import 'package:yoyo/presentation/widgets/components/info/episode_container.dart';
import 'package:yoyo/presentation/widgets/customs/icons/icon_button.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';

class StreamingScreen extends StatefulWidget {
  final String id;
  final List<EpisodeEntity> episodes;
  const StreamingScreen({
    Key? key,
    required this.id,
    required this.episodes,
  }) : super(key: key);

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  @override
  void initState() {
    context.read<StreamlinkCubit>().onFetchStreamLinks(widget.id);
    context.read<PlayingCubit>().setId(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isFullscreen = context.select((FullscreenCubit fs) => fs.state);
        final givenId = context.select((PlayingCubit pl) => pl.state);
        return Scaffold(
          appBar: isFullscreen
              ? null
              : AppBar(
                  leading: CustomIconButton(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<StreamlinkCubit, StreamlinkState>(
                builder: (context, state) {
                  if (state is StreamlinkLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YoYoPlayer(
                          // onVideoInitCompleted: (controller) {
                          //   controller.seekTo(const Duration(minutes: 5));
                          // },
                          allowCacheFile: true,
                          url: state.streamLink
                              .sources[state.streamLink.sources.length - 2].url,
                          aspectRatio: 16 / 9,
                          videoStyle: VideoStyle(
                            videoQualityBgColor:
                                Theme.of(context).secondaryHeaderColor,
                            backwardIconColor:
                                Theme.of(context).secondaryHeaderColor,
                            forwardIconColor:
                                Theme.of(context).secondaryHeaderColor,
                            playButtonIconColor:
                                Theme.of(context).secondaryHeaderColor,
                            fullscreenIcon: Icon(
                              Icons.fullscreen_rounded,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          videoLoadingStyle: VideoLoadingStyle(
                            loading: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ),
                          onFullScreen: (value) {
                            context.read<FullscreenCubit>().changeScreen(value);
                          },
                        ),
                      ],
                    );
                  } else if (state is StreamlinkLoading) {
                    return Shimmer.fromColors(
                      highlightColor: kDarkGrey2Color,
                      baseColor: kDarkGrey1Color,
                      child: Container(
                        height: 27.h,
                        width: 100.w,
                        decoration: BoxDecoration(color: kDarkGrey1Color),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              // episode.title ?? 'episode ${episode.number}'
              if (!isFullscreen) SizedBox(height: 2.h),
              if (!isFullscreen)
                CustomText(
                  CustomFunctions.getPlayingEpisode(
                              givenId ?? '', widget.episodes)
                          .title ??
                      'episode ${CustomFunctions.getPlayingEpisode(givenId ?? '', widget.episodes).number.toString()}',
                  size: 20.sp,
                ),
              if (!isFullscreen) SizedBox(height: 1.h),
              if (CustomFunctions.getPlayingEpisode(
                              givenId ?? '', widget.episodes)
                          .description !=
                      null &&
                  !isFullscreen)
                ReadMoreText(
                  CustomFunctions.removeTags(CustomFunctions.getPlayingEpisode(
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
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              if (!isFullscreen) SizedBox(height: 1.h),
              if (!isFullscreen) const Divider(),
              if (!isFullscreen) const CustomText('EPISODES'),
              if (!isFullscreen) SizedBox(height: 2.h),
              if (!isFullscreen)
                Expanded(
                  child: ListView(
                    key: const PageStorageKey<String>('streamingPage'),
                    children: widget.episodes.map((e) {
                      return EpisodeContainer(
                        haveDesc: false,
                        onTap: e.id == givenId
                            ? null
                            : () {
                                context
                                    .read<StreamlinkCubit>()
                                    .onFetchStreamLinks(e.id);
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
        );
      },
    );
  }
}
