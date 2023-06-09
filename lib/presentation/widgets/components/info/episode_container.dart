// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/domain/entity/info_entity.dart';
import 'package:yoyo/presentation/widgets/customs/icons/icon_button.dart';

import '../../customs/text.dart';

class EpisodeContainer extends StatelessWidget {
  final EpisodeEntity episode;
  final VoidCallback? onTap;
  final String? subtitle;
  final bool? haveDesc;
  const EpisodeContainer({
    Key? key,
    required this.episode,
    this.onTap,
    this.subtitle,
    this.haveDesc = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimens.paddingB1,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.minRadius)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.minRadius),
                  child: CachedNetworkImage(
                    imageUrl: episode.image,
                    height: 12.h,
                    width: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CustomIconButton(
                    onTap: onTap,
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      color: AppTheme.white,
                    ),
                    bgColor: AppTheme.white,
                    radius: AppDimens.maxRadius,
                  ),
                ),
              ],
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    episode.title != null
                        ? '${episode.number}. ${episode.title}'
                        : '${episode.number}. Episode ${episode.number}',
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                  if (subtitle != null)
                    CustomText(
                      subtitle,
                      size: 15.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  if (episode.description != null && (haveDesc ?? true))
                    CustomText(
                      episode.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      size: 14.sp,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
