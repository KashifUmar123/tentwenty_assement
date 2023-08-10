import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/utils/locator/locator.dart';
import 'package:tentwenty_assement/utils/nav_service.dart';
import 'package:tentwenty_assement/utils/routes/route_names.dart';

import '../../../model/upcoming_movies_model.dart';
import '../../../res/app_colors.dart';
import '../../../view_model/upcoming_movies_view_model.dart';

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
  final NavService navService = locator<NavService>();
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
              // await upcomingMoviesViewModel
              //     .fetchMovieDetails(widget.results.id);
              upcomingMoviesViewModel.setSelectedResults(widget.results);
              navService.nav.pushNamed(RoutesNames.movieDetails);
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
