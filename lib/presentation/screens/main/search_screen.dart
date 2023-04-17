import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/presentation/cubits/trending/trending_cubit.dart';
import 'package:yoyo/presentation/widgets/components/home/introduction.dart';

import '../../widgets/components/home/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<TrendingCubit>().onFetchTrendingAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Introduction(
          search: SearchBar(
            width: 80.w,
            borderColor: Theme.of(context).secondaryHeaderColor,
            controller: searchController,
          ),
        ),
      ],
    );
  }
}
