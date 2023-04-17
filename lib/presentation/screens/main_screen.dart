import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/constants/constant.dart';
import 'package:yoyo/core/constants/string.dart';
import 'package:yoyo/presentation/cubits/common/bnb_cubit.dart';
import 'package:yoyo/presentation/screens/main/account_screen.dart';
import 'package:yoyo/presentation/screens/main/search_screen.dart';

import '../../core/global/global.dart';
import '../cubits/recent/recent_cubit.dart';
import '../cubits/trending/trending_cubit.dart';
import '../cubits/upcoming/upcoming_cubit.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final selectedIndex = context.select((BnbCubit bnb) => bnb.state);
        return Scaffold(
          appBar: selectedIndex == 0 || selectedIndex == 2
              ? AppBar(
                  backgroundColor: kTransparentColor,
                  leading: selectedIndex == 0 ? Image.asset(lgLogo) : null,
                  title: selectedIndex == 2
                      ? CustomText(
                          'My Account',
                          size: 18.sp,
                          weight: FontWeight.w600,
                        )
                      : null,
                )
              : null,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              HomeScreen(),
              SearchScreen(),
              AccountScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            key: globalNavigationKey,
            unselectedItemColor: kWhiteColor,
            selectedItemColor: Theme.of(context).primaryColor,
            backgroundColor: kTransparentColor,
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (value) {
              context.read<BnbCubit>().navigate(value);
              pageController.jumpToPage(value);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Iconify(
                  Ri.home_6_line,
                  color: kWhiteColor,
                ),
                activeIcon: Iconify(
                  Ri.home_6_fill,
                  color: Theme.of(context).primaryColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Iconify(
                  Ri.search_line,
                  color: kWhiteColor,
                ),
                activeIcon: Iconify(
                  Ri.search_eye_fill,
                  color: Theme.of(context).primaryColor,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: const Iconify(
                  Ri.user_line,
                  color: kWhiteColor,
                ),
                activeIcon: Iconify(
                  Ri.user_fill,
                  color: Theme.of(context).primaryColor,
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
