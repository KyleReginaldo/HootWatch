import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/constants/svg_icon.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/core/utils/custom_functions.dart';
import 'package:yoyo/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/ani_container.dart';
import 'package:yoyo/presentation/widgets/customs/button/elevated_icon_button.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../cubits/user/current_user/current_user_cubit.dart';
import '../../cubits/user/user_cubit.dart';
import '../../widgets/customs/icons/icon_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    context
        .read<UserCubit>()
        .onFetchUser(uid: FirebaseAuth.instance.currentUser?.uid ?? '');
    context
        .read<FavoriteCubit>()
        .onFetchFavorites(userId: FirebaseAuth.instance.currentUser?.uid ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CurrentUserCubit>().onFetchFbUser();
        return true;
      },
      child: Builder(builder: (context) {
        final favState = context.select((FavoriteCubit fav) => fav.state);
        return Scaffold(
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
          body: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserFetched) {
                return Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 35.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                getStarted,
                              ),
                              opacity: 0.8,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppDimens.maxRadius),
                              bottomRight: Radius.circular(AppDimens.maxRadius),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -2.h,
                          child: Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: AppTheme.greyLight2,
                                offset: Offset(0, 0),
                                blurRadius: 50,
                                spreadRadius: 1,
                              ),
                            ]),
                            child: ClipOval(
                              child: state.user.imageLink == null
                                  ? Image.asset(
                                      'assets/image/person.png',
                                      height: 12.h,
                                      width: 12.h,
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: state.user.imageLink!,
                                      height: 12.h,
                                      width: 12.h,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedIconButton(
                          title: 'Edit Profile',
                          icon: SvgPicture.asset(
                            SvgIcon.edit,
                            color: AppTheme.white,
                          ),
                          bgColor: AppTheme.greyDark2,
                          onTap: () {
                            AutoRouter.of(context)
                                .push(EditProfileRoute(user: state.user));
                          },
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        CustomElevatedIconButton(
                          onTap: () async {
                            await FirebaseAuth.instance
                                .signOut()
                                .then((value) => AutoRouter.of(context).pop());
                          },
                          title: 'Logout',
                          icon: SvgPicture.asset(
                            SvgIcon.logout,
                            color: AppTheme.white,
                          ),
                          bgColor: AppTheme.greyDark2,
                          iconColor: AppTheme.white,
                        ),
                      ],
                    ),
                    CustomText(
                      state.user.username,
                      size: 18.sp,
                    ),
                    CustomText(
                      state.user.email,
                      size: 14.sp,
                      color: AppTheme.greyLight2,
                    ),
                    CustomText(
                      'Bio: ${state.user.bio}',
                      size: 15.sp,
                      color: AppTheme.systemBlue,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.facebook),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Iconify(
                            Mdi.instagram,
                            color: AppTheme.greyLight2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Iconify(
                            Mdi.twitter,
                            color: AppTheme.greyLight2,
                          ),
                        ),
                      ],
                    ),
                    if (favState is FavoriteLoaded)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 1.h),
                          child: CustomText(
                            'Favorites',
                            size: 16.sp,
                            weight: FontWeight.w600,
                            color: AppTheme.greyLight2,
                          ),
                        ),
                      ),
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        if (state is FavoriteLoaded) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.h),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: state.favorites
                                      .map(
                                        (e) => CustomAniContainer(
                                          onTap: () {
                                            AutoRouter.of(context)
                                                .push(InfoRoute(id: e.id));
                                          },
                                          padding: EdgeInsets.only(right: 1.h),
                                          color: Color(
                                              CustomFunctions.convertHexToInt(
                                                  e.color ?? '#FE0202')),
                                          image: e.image,
                                          title: e.title.english ??
                                              e.title.userPreferred ??
                                              e.title.romaji,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          );
                        } else if (state is FavoriteLoading) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: EdgeInsets.all(1.h),
                                  child: FadeShimmer(
                                    width: 32.w,
                                    height: 20.h,
                                    radius: 8,
                                    highlightColor: AppTheme.black,
                                    baseColor: AppTheme.greyDark2,
                                  ),
                                );
                              }),
                            ),
                          );
                        } else if (state is FavoriteEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                'Populate your list\nexplore the world of anime.',
                                size: 16.sp,
                                color: AppTheme.greyLight2,
                                weight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                              CustomElevatedIconButton(
                                title: 'Explore',
                                onTap: () {
                                  AutoRouter.of(context).popUntilRoot();
                                },
                                icon: const Icon(Icons.explore_rounded),
                                bgColor: AppTheme.greyDark2,
                                iconColor: AppTheme.white,
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                );
              } else if (state is FavoriteLoading) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: EdgeInsets.all(1.h),
                              child: FadeShimmer(
                                width: 32.w,
                                height: 20.h,
                                radius: 8,
                                highlightColor: AppTheme.black,
                                baseColor: AppTheme.greyDark2,
                              ),
                            )),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      }),
    );
  }
}
