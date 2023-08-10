import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';

class SearchQueryView extends StatefulWidget {
  const SearchQueryView({super.key});

  @override
  State<SearchQueryView> createState() => _SearchQueryViewState();
}

class _SearchQueryViewState extends State<SearchQueryView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.5.w),
        color: AppColors.lightGreyColor,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          separatorBuilder: (context, index) => SizedBox(
            height: 10.h,
          ),
          itemCount: 3,
          itemBuilder: (context, index) => const SearchMovieTileWidget(),
        ),
      ),
    );
  }
}

class SearchMovieTileWidget extends StatefulWidget {
  const SearchMovieTileWidget({super.key});

  @override
  State<SearchMovieTileWidget> createState() => _SearchMovieTileWidgetState();
}

class _SearchMovieTileWidgetState extends State<SearchMovieTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              AppImages.image,
              height: 100.h,
              width: 130.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 21.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Timless",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Fantasy",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.midGreyColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.more_horiz,
            color: AppColors.greenColor,
          )
        ],
      ),
    );
  }
}
