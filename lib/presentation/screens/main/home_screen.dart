import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo/presentation/cubits/recent/recent_cubit.dart';
import 'package:yoyo/presentation/widgets/components/home/last_watched_container.dart';
import 'package:yoyo/presentation/widgets/components/home/popular_container.dart';
import 'package:yoyo/presentation/widgets/components/home/trending_container.dart';
import 'package:yoyo/presentation/widgets/components/home/upcoming_container.dart';

import '../../cubits/common/scroll_cubit.dart';
import '../../cubits/lastWatched/last_watched_cubit.dart';
import '../../cubits/trending/trending_cubit.dart';
import '../../cubits/upcoming/upcoming_cubit.dart';
import '../../widgets/components/home/recent_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    scrollController.addListener(() {
      context
          .read<ScrollCubit>()
          .listen(scrollController.position.pixels >= 20);
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<RecentCubit>().onFetchRecentAnime();
        context.read<UpcomingCubit>().onFetchUpcomingAnime();
        context.read<TrendingCubit>().onFetchTrendingAnime();
        context.read<LastWatchedCubit>().onFetchLastWatched(
            userId: FirebaseAuth.instance.currentUser?.uid ?? "");
      },
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.zero,
        children: const [
          TrendingContainer(),
          LastWatchedContainer(),
          RecentContainer(),
          PopularContainer(),
          UpcomingContainer(),
        ],
      ),
    );
  }
}
