import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/res/app_colors.dart';
import 'package:tentwenty_assement/res/app_images.dart';
import 'package:tentwenty_assement/res/movie_search_status.dart';
import 'package:tentwenty_assement/view/home/widgets/genres_view.dart';
import 'package:tentwenty_assement/view/home/widgets/search_query_view.dart';
import 'package:tentwenty_assement/view/home/widgets/upcoming_movies_view.dart';
import 'package:tentwenty_assement/view_model/upcoming_movies_view_model.dart';
import '../widgets/search_widget.dart';

class MoviesTab extends StatefulWidget {
  const MoviesTab({super.key});

  @override
  State<MoviesTab> createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  ValueNotifier<bool> isSearchOpen = ValueNotifier(false);

  late UpcomingMoviesViewModel upcomingMoviesViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      upcomingMoviesViewModel.fecthUpcomingMovies();
      upcomingMoviesViewModel.fetchGenres();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    upcomingMoviesViewModel = Provider.of<UpcomingMoviesViewModel>(context);
    return SizedBox(
      height: 812.h - 75.h,
      child: Column(
        children: [
          Container(
            color: AppColors.whiteColor,
            height: 111.h,
            child: Column(
              children: [
                SizedBox(
                  height: 44.h,
                ),
                SearchWidget(
                  isSearchOpen: isSearchOpen,
                ),
              ],
            ),
          ),
          _buildConditionalUi(),
        ],
      ),
    );
  }

  _buildConditionalUi() {
    log("IN rendering ${upcomingMoviesViewModel.currentSearchStatus.value.toString()}");
    switch (upcomingMoviesViewModel.currentSearchStatus.value) {
      case MoiveSearchStatus.SearchNotCliecked:
        return const UpcomingMoviesView();
      case MoiveSearchStatus.SearchClicked:
        return const GenresView();
      case MoiveSearchStatus.SearchActiveTyping:
        return const SearchQueryView();
      default:
        return Container();
    }
  }
}
