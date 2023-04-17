// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:yoyo/domain/entity/info_entity.dart';
import 'package:yoyo/presentation/cubits/common/fullscreen_cubit.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isFullscreen = context.select((FullscreenCubit fs) => fs.state);
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
          body: BlocBuilder<StreamlinkCubit, StreamlinkState>(
            builder: (context, state) {
              if (state is StreamlinkLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoYoPlayer(
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
                    SizedBox(height: 2.h),
                    const CustomText('EPISODES'),
                    Expanded(
                      child: ListView(
                        children: widget.episodes.map((e) {
                          return EpisodeContainer(
                            onTap: e.id == state.id
                                ? null
                                : () {
                                    context
                                        .read<StreamlinkCubit>()
                                        .onFetchStreamLinks(e.id);
                                  },
                            episode: e,
                            subtitle: e.id == state.id ? 'Playing...' : null,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
