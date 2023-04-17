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
  const EpisodeContainer({
    Key? key,
    required this.episode,
    this.onTap,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Container(
        decoration: BoxDecoration(
            color: subtitle != null
                ? Theme.of(context).primaryColor.withOpacity(0.6)
                : null,
            borderRadius: BorderRadius.circular(kMinRadius)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(kMinRadius),
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
                    icon: Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    episode.title ?? 'episode ${episode.number}',
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                  if (subtitle != null)
                    CustomText(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      size: 16.sp,
                      color: kWhiteColor,
                    ),
                  if (episode.description != null)
                    CustomText(
                      episode.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
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
