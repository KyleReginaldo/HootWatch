import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yoyo/presentation/cubits/recent/recent_cubit.dart';
import 'package:yoyo/presentation/widgets/components/home/recent_container.dart';
import 'package:yoyo/presentation/widgets/components/home/trending_container.dart';
import 'package:yoyo/presentation/widgets/components/home/upcoming_container.dart';
import 'package:yoyo/presentation/widgets/customs/ani_container.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';

import '../../../core/constants/constant.dart';
import '../../../core/utils/custom_functions.dart';
import '../../cubits/trending/trending_cubit.dart';
import '../../cubits/upcoming/upcoming_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.4.h),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<RecentCubit>().onFetchRecentAnime();
          context.read<UpcomingCubit>().onFetchUpcomingAnime();
          context.read<TrendingCubit>().onFetchTrendingAnime();
        },
        child: ListView(
          children: const [
            TrendingContainer(),
            RecentContainer(),
            UpcomingContainer(),
          ],
        ),
      ),
    );
  }
}