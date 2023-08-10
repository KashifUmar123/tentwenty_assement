import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/res/app_colors.dart';

import 'package:tentwenty_assement/utils/locator/locator.dart';
import 'package:tentwenty_assement/utils/nav_service.dart';
import 'package:tentwenty_assement/utils/routes/route_names.dart';
import 'package:tentwenty_assement/view_model/movies_view_model.dart';

class MoviesDetilsView extends StatefulWidget {
  const MoviesDetilsView({super.key});

  @override
  State<MoviesDetilsView> createState() => _MoviesDetilsViewState();
}

class _MoviesDetilsViewState extends State<MoviesDetilsView> {
  final NavService navService = locator<NavService>();
  late MoviesViewModel upcomingMoviesViewModel;
  @override
  Widget build(BuildContext context) {
    upcomingMoviesViewModel = Provider.of<MoviesViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUpperDetailsWidget(),
            SizedBox(
              height: 27.h,
            ),
            _buildMovieLowerDetails(),
          ],
        ),
      ),
    );
  }

  Padding _buildMovieLowerDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Genres",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Row(
            children: [
              _genresWidgetTile(
                text: "Action",
                color: AppColors.greenColor,
              ),
              _genresWidgetTile(
                text: "Thriller",
                color: AppColors.pinkColor,
              ),
              _genresWidgetTile(
                text: "Science",
                color: AppColors.blueColor,
              ),
              _genresWidgetTile(
                text: "Fiction",
                color: AppColors.yellowColor,
              ),
            ],
          ),
          SizedBox(
            height: 22.h,
          ),
          const Divider(
            color: AppColors.blackColor,
            height: 1,
          ),
          SizedBox(
            height: 15.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Overview",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          SizedBox(
            height: 133.h,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                AutoSizeText(
                  upcomingMoviesViewModel.selectedResults!.overview,
                  style: TextStyle(
                    color: const Color(0XFF8F8F8F),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _genresWidgetTile({
    required String text,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Container(
        height: 24.h,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildUpperDetailsWidget() {
    return SizedBox(
      height: 470.h,
      child: Stack(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${upcomingMoviesViewModel.selectedResults!.posterPath}',
            fit: BoxFit.cover,
            height: 470.h,
            width: double.infinity,
          ),
          Container(
            height: 470.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.blackColor.withOpacity(0),
                  Colors.black.withOpacity(.2),
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 59.h,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        locator<NavService>().nav.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Watch",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 180.h,
                ),
                Text(
                  "In theaters ${upcomingMoviesViewModel.selectedResults!.releaseDate}",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () {
                    locator<NavService>()
                        .nav
                        .pushNamed(RoutesNames.cinemaDetails);
                  },
                  child: Container(
                    height: 50.h,
                    width: 243.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.skyBlueColor,
                    ),
                    child: Center(
                      child: Text(
                        "Get Tickets",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () async {
                    log("Clicked");
                    await upcomingMoviesViewModel.getTrailerUrl();
                    log(upcomingMoviesViewModel.selectedTrailerUrl);
                    if (upcomingMoviesViewModel.selectedTrailerUrl != "") {
                      navService.nav
                          .pushNamed(RoutesNames.watchTrailer, arguments: {
                        "url": upcomingMoviesViewModel.selectedTrailerUrl,
                      });
                    }
                  },
                  child: Container(
                    height: 50.h,
                    width: 243.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: AppColors.skyBlueColor,
                        )),
                    child: Center(
                      child: Text(
                        "Watch Trailer",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
