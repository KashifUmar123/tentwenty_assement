import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';

class CinemaDatesWidget extends StatefulWidget {
  const CinemaDatesWidget({super.key});

  @override
  State<CinemaDatesWidget> createState() => _CinemaDatesWidgetState();
}

class _CinemaDatesWidgetState extends State<CinemaDatesWidget> {
  var mapping = [
    [0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SizedBox(
        height: 160.h,
        width: 249.w,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "12:30",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 9.w,
                ),
                Text(
                  "Cinetech + hall 1",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8F8F8F),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9.h,
            ),
            Container(
              height: 145.h,
              width: 249.w,
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 15.w,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.skyBlueColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < 10; i++)
                    _getRows(
                      i: i,
                      cols: 24,
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text(
                  "From ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  "\$50 ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Text(
                  "or ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  "2500 bouns",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _getRows({
    required int i,
    required cols,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int j = 0; j < cols; j++)
          mapping[i][j] == 0
              ? SizedBox(
                  height: 2.3.h,
                  width: 3.07.w,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.4.h),
                  child: Image.asset(
                    AppImages.regular,
                    height: 2.3.h,
                    width: 3.07.w,
                  ),
                )
      ],
    );
  }
}
