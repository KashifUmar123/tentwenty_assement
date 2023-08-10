import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/view_model/upcoming_movies_view_model.dart';
import '../../../data/response/status.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';

class GenresView extends StatefulWidget {
  const GenresView({super.key});

  @override
  State<GenresView> createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> {
  late UpcomingMoviesViewModel upcomingMoviesViewModel;
  @override
  Widget build(BuildContext context) {
    upcomingMoviesViewModel = Provider.of<UpcomingMoviesViewModel>(context);
    switch (upcomingMoviesViewModel.genres.status) {
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 163 / 100,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
              ),
              itemCount: upcomingMoviesViewModel
                  .genres.data!.genres.length, // Total number of items

              itemBuilder: (context, index) {
                return Container(
                  height: 100.h,
                  width: 163.w,
                  decoration: BoxDecoration(
                    // color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Stack(
                    children: [
                      upcomingMoviesViewModel
                                  .genres.data!.genres[index].imagePath !=
                              ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                upcomingMoviesViewModel
                                    .genres.data!.genres[index].imagePath,
                                fit: BoxFit.fitHeight,
                                height: 100.h,
                                width: 163.w,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                AppImages.image,
                                fit: BoxFit.fitHeight,
                                height: 100.h,
                                width: 163.w,
                              ),
                            ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: .001,
                              sigmaY: .001), // Adjust the blur intensity
                          child: Container(
                            width: 163.w,
                            height: 100.h,
                            color: Colors.black.withOpacity(.3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 20.h, left: 10.w),
                                  child: Text(
                                    upcomingMoviesViewModel
                                        .genres.data!.genres[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );

      case Status.ERROR:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              upcomingMoviesViewModel.genres.message ?? "Something wen't wrong",
              style: const TextStyle(
                color: AppColors.blackColor,
              ),
            ),
          ),
        );

      default:
        return Container();
    }
  }
}
