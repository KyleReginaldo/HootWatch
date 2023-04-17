// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/presentation/cubits/common/episodes/episodes_cubit.dart';
import 'package:yoyo/presentation/cubits/info/info_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import 'package:readmore/readmore.dart';

import '../../../core/constants/constant.dart';
import '../../../core/router/custom_router.dart';
import '../../widgets/components/info/episode_container.dart';
import '../../widgets/customs/icons/icon_button.dart';

class InfoScreen extends StatefulWidget {
  final String id;
  const InfoScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    context.read<InfoCubit>().onFetchAnimeInfo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: state.Info.cover,
                    fit: BoxFit.cover,
                    height: 35.h,
                    width: 100.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          state.Info.title.userPreferred ??
                              state.Info.title.english ??
                              state.Info.title.romaji,
                          size: 20.sp,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 1.h),
                        Wrap(
                          runSpacing: 4,
                          spacing: 8,
                          children: state.Info.genres.map((e) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 0.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.3),
                                border: Border.all(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                borderRadius: BorderRadius.circular(
                                  kMidRadius,
                                ),
                              ),
                              child: CustomText(e),
                            );
                          }).toList(),
                        ),
                        if (state.Info.description != null)
                          SizedBox(height: 2.h),
                        if (state.Info.description != null)
                          CustomText(
                            'Synopsis',
                            size: 16.sp,
                            weight: FontWeight.w600,
                          ),
                        if (state.Info.description != null)
                          SizedBox(height: 1.h),
                        if (state.Info.description != null)
                          ReadMoreText(
                            CustomFunctions.removeTags(state.Info.description!),
                            trimLines: 4,
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
                        SizedBox(height: 2.h),
                        const CustomText('EPISODES'),
                        SizedBox(height: 1.h),
                        Column(
                          children: state.Info.episodes.toSet().map((e) {
                            return EpisodeContainer(
                              episode: e,
                              onTap: () {
                                AutoRouter.of(context).push(StreamingRoute(
                                    id: e.id, episodes: state.Info.episodes));
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is InfoLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
