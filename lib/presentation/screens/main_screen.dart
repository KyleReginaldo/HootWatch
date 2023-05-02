import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/constants/svg_icon.dart';
import 'package:yoyo/presentation/cubits/common/scroll_cubit.dart';
import 'package:yoyo/presentation/cubits/popular/popular_cubit.dart';
import 'package:yoyo/presentation/screens/main/mylist_screen.dart';

import '../../core/global/global.dart';
import '../../core/router/custom_router.dart';
import '../../domain/entity/search_entity.dart';
import '../cubits/common/color_cubit.dart';
import '../cubits/state.dart';
import '../widgets/components/search/custom_search_delegate.dart';
import 'main/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageController = PageController();
  @override
  void initState() {
    context.read<RecentCubit>().onFetchRecentAnime();
    context.read<UpcomingCubit>().onFetchUpcomingAnime();
    context.read<RandomCubit>().onFetchRandomAnime();
    context.read<LastWatchedCubit>().onFetchLastWatched(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
    context.read<TrendingCubit>().onFetchTrendingAnime();
    context.read<CurrentUserCubit>().onFetchFbUser();
    context.read<PopularCubit>().onFetchPopularAnime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final selectedIndex = context.select((BnbCubit bnb) => bnb.state);
        final currentUser = context.select((CurrentUserCubit cr) => cr.state);
        final scrolling = context.select((ScrollCubit sc) => sc.state);
        final bgColor = context.select((ColorCubit clr) => clr.state);

        return Scaffold(
          extendBodyBehindAppBar: selectedIndex == 0,
          appBar: AppBar(
            backgroundColor: scrolling ? bgColor.withOpacity(0.6) : null,
            leading: Image.asset(a17),
            actions: [
              IconButton(
                onPressed: () async {
                  await showSearch<SearchEntity>(
                    context: context,
                    delegate: SearchPageDelegate(
                        searchBloc: BlocProvider.of<SearchBloc>(context)),
                  );
                },
                icon: SvgPicture.asset(
                  SvgIcon.search,
                  color: AppTheme.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const AccountRoute());
                  },
                  child: ClipOval(
                    child: currentUser?.photoURL != null
                        ? CachedNetworkImage(
                            imageUrl: currentUser!.photoURL!,
                            height: 5.h,
                            width: 5.h,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/image/person.png',
                            height: 5.h,
                            width: 5.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              )
            ],
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              const HomeScreen(),
              Container(),
              const MylistScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            key: globalNavigationKey,
            backgroundColor: AppTheme.transparent,
            elevation: 0,
            currentIndex: selectedIndex,
            selectedItemColor: AppTheme.greyLight2,
            unselectedItemColor: AppTheme.grey,
            onTap: (value) {
              context.read<BnbCubit>().navigate(value);
              pageController.jumpToPage(value);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  SvgIcon.home,
                  color: AppTheme.grey,
                ),
                activeIcon: SvgPicture.asset(
                  SvgIcon.home,
                  color: AppTheme.greyLight2,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  SvgIcon.play,
                  color: AppTheme.grey,
                ),
                activeIcon: SvgPicture.asset(
                  SvgIcon.play,
                  color: AppTheme.greyLight2,
                ),
                label: 'Clips',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  SvgIcon.bookmark,
                  color: AppTheme.grey,
                ),
                activeIcon: SvgPicture.asset(
                  SvgIcon.bookmark,
                  color: AppTheme.greyLight2,
                ),
                label: 'Bookmark',
              ),
            ],
          ),
        );
      },
    );
  }
}
