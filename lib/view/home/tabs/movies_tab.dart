import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/model/upcoming_movies.dart';

import 'package:tentwenty_assement/res/app_colors.dart';
import 'package:tentwenty_assement/res/app_images.dart';
import 'package:tentwenty_assement/view_model/upcoming_movies_view_model.dart';

import '../../../data/response/status.dart';

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
          _buildUi(),
        ],
      ),
    );
  }

  _buildUi() {
    switch (upcomingMoviesViewModel.upcomingMovies.status) {
      case Status.LOADING:
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.blackColor,
          ),
        );

      case Status.COMPLETED:
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.5.w),
            color: AppColors.lightGreyColor,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount:
                  upcomingMoviesViewModel.upcomingMovies.data!.results.length,
              itemBuilder: (context, index) => MovieTileWidget(
                results:
                    upcomingMoviesViewModel.upcomingMovies.data!.results[index],
              ),
            ),
          ),
        );

      case Status.ERROR:
        return Center(
          child: Text(
            upcomingMoviesViewModel.upcomingMovies.message ??
                "Something wen't wrong",
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        );

      default:
        return Container();
    }
  }
}

class MovieTileWidget extends StatefulWidget {
  const MovieTileWidget({
    super.key,
    required this.results,
  });

  final Results results;

  @override
  State<MovieTileWidget> createState() => _MovieTileWidgetState();
}

class _MovieTileWidgetState extends State<MovieTileWidget> {
  late UpcomingMoviesViewModel upcomingMoviesViewModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    upcomingMoviesViewModel = Provider.of<UpcomingMoviesViewModel>(context);
    return SizedBox(
      height: 180.h,
      width: 335.w,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${widget.results.backdropPath}',
              fit: BoxFit.cover,
              height: 180.h,
              width: 335.w,
            ),
          ),
          InkWell(
            onTap: () async {
              log("clicked");
              await upcomingMoviesViewModel
                  .fetchMovieDetails(widget.results.id);
            },
            child: Container(
              height: 180.h,
              width: 335.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  colors: [
                    AppColors.blackColor.withOpacity(0),
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.results.title,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.isSearchOpen,
  });

  final ValueNotifier<bool> isSearchOpen;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.5.w),
      child: Container(
        width: 334.w,
        height: 52.h,
        decoration: widget.isSearchOpen.value
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.lightGreyColor,
              )
            : null,
        child: widget.isSearchOpen.value
            ? SizedBox(
                width: 334.w,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    const Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 195.w,
                      height: 40.h,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "TV shows, movies and more",
                          hintStyle: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14.sp,
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            widget.isSearchOpen.value =
                                !widget.isSearchOpen.value;
                          },
                        );
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Watch",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      log(widget.isSearchOpen.value.toString());
                      setState(() {
                        widget.isSearchOpen.value = !widget.isSearchOpen.value;
                      });
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
