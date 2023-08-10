import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assement/res/app_images.dart';
import '../../res/app_colors.dart';
import '../../utils/locator/locator.dart';
import '../../utils/nav_service.dart';

class SelectSeatsScreen extends StatefulWidget {
  const SelectSeatsScreen({super.key});

  @override
  State<SelectSeatsScreen> createState() => _SelectSeatsScreenState();
}

class _SelectSeatsScreenState extends State<SelectSeatsScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 69.5.h,
            ),
            _header(),
            Expanded(
              child: SizedBox(
                height: 680.h,
                width: 375.w,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 380.h,
                      width: 330.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      color: AppColors.lightGreyColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 60.h,
                          ),
                          Image.asset(AppImages.screen),
                          Center(
                            child: SizedBox(
                              height: 189.h,
                              width: 328.w,
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
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 15.r,
                                  backgroundColor: AppColors.whiteColor,
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.blackColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 15.r,
                                  backgroundColor: AppColors.whiteColor,
                                  child: const Icon(
                                    Icons.remove,
                                    color: AppColors.blackColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _seatsDetailsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _seatsDetailsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 252.h,
      child: Column(
        children: [
          SizedBox(
            height: 26.h,
          ),
          Row(
            children: [
              _seatMetaData(imagePath: AppImages.selected, text: "Selected"),
              _seatMetaData(
                  imagePath: AppImages.notAvailable, text: "Not Available"),
            ],
          ),
          SizedBox(
            height: 21.h,
          ),
          Row(
            children: [
              _seatMetaData(imagePath: AppImages.vip, text: "VIP (\$150)"),
              _seatMetaData(imagePath: AppImages.regular, text: "Regular"),
            ],
          ),
          SizedBox(
            height: 32.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 30.h,
              width: 97.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.midGreyColor,
              ),
              child: Row(
                children: [
                  Text(
                    "4/3 row",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.close,
                    size: 15.73.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          Row(
            children: [
              Container(
                height: 50.h,
                width: 108.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.midGreyColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Toal Price",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "\$50",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 50.h,
                width: 216.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.greenColor,
                ),
                child: Center(
                  child: Text(
                    "Proceed to pay",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _seatMetaData({
    required String imagePath,
    required String text,
  }) {
    return SizedBox(
      height: 20.h,
      width: 130.w,
      child: Row(
        children: [
          Image.asset(imagePath),
          SizedBox(
            width: 12.8.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
                  height: 6.63.h,
                  width: 6.98.h,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.4.h),
                  child: Image.asset(
                    AppImages.regular,
                    height: 6.63.h,
                    width: 6.98.h,
                  ),
                )
      ],
    );
  }

  _header() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => locator<NavService>().nav.pop(),
            child: const Icon(Icons.arrow_back_ios),
          ),
          Column(
            children: [
              Text(
                "The King’s Man",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "In theaters december 22, 2021",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.skyBlueColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }
}
