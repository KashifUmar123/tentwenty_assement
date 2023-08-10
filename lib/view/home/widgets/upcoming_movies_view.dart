import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/view/home/widgets/movie_tile_widget.dart';
import 'package:tentwenty_assement/view_model/upcoming_movies_view_model.dart';

import '../../../data/response/status.dart';
import '../../../res/app_colors.dart';

class UpcomingMoviesView extends StatefulWidget {
  const UpcomingMoviesView({super.key});

  @override
  State<UpcomingMoviesView> createState() => _UpcomingMoviesViewState();
}

class _UpcomingMoviesViewState extends State<UpcomingMoviesView> {
  late UpcomingMoviesViewModel upcomingMoviesViewModel;
  @override
  Widget build(BuildContext context) {
    upcomingMoviesViewModel = Provider.of<UpcomingMoviesViewModel>(context);
    switch (upcomingMoviesViewModel.upcomingMovies.status) {
      case Status.LOADING:
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.blackColor,
            ),
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
              color: AppColors.blackColor,
            ),
          ),
        );

      default:
        return Container();
    }
  }
}
