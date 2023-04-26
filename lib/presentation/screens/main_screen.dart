import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/app_theme.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/constants/string.dart';
import 'package:yoyo/domain/entity/search_entity.dart';
import 'package:yoyo/presentation/cubits/common/bnb_cubit.dart';
import 'package:yoyo/presentation/cubits/lastWatched/last_watched_cubit.dart';
import 'package:yoyo/presentation/screens/main/account_screen.dart';

import '../../core/global/global.dart';
import '../blocs/search/search_bloc.dart';
import '../cubits/recent/recent_cubit.dart';
import '../cubits/trending/trending_cubit.dart';
import '../cubits/upcoming/upcoming_cubit.dart';
import '../widgets/components/search/custom_search_delegate.dart';
import '../widgets/customs/text.dart';
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
    context.read<TrendingCubit>().onFetchTrendingAnime();
    context.read<LastWatchedCubit>().onFetchLastWatched(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final selectedIndex = context.select((BnbCubit bnb) => bnb.state);
        return Scaffold(
          extendBodyBehindAppBar: selectedIndex == 0,
          appBar: selectedIndex == 0 || selectedIndex == 2
              ? AppBar(
                  leading: selectedIndex == 0 ? Image.asset(aniflixLogo) : null,
                  title: selectedIndex == 2
                      ? CustomText(
                          'My Account',
                          size: 18.sp,
                          weight: FontWeight.w600,
                        )
                      : null,
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await showSearch<SearchEntity>(
                          context: context,
                          delegate: SearchPageDelegate(
                              searchBloc: BlocProvider.of<SearchBloc>(context)),
                        );
                      },
                      icon: const Iconify(
                        Ri.search_eye_line,
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                )
              : null,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              const HomeScreen(),
              Container(),
              const AccountScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            key: globalNavigationKey,
            backgroundColor: kTransparentColor,
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (value) {
              context.read<BnbCubit>().navigate(value);
              pageController.jumpToPage(value);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Iconify(
                  Ri.home_6_line,
                  color: AppTheme.grey,
                ),
                activeIcon: Iconify(
                  Ri.home_6_fill,
                  color: AppTheme.greyLight2,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  Ic.twotone_travel_explore,
                  color: AppTheme.grey,
                ),
                activeIcon: Iconify(
                  Ic.twotone_travel_explore,
                  color: AppTheme.greyLight2,
                ),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  Ri.user_line,
                  color: AppTheme.grey,
                ),
                activeIcon: Iconify(
                  Ri.user_fill,
                  color: AppTheme.greyLight2,
                ),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
