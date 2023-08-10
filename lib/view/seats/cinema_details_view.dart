import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assement/res/app_colors.dart';
import 'package:tentwenty_assement/utils/nav_service.dart';
import 'package:tentwenty_assement/view/seats/widgets/cinema_booking_widget.dart';
import 'package:tentwenty_assement/view/seats/widgets/date_tile_widget.dart';

import '../../utils/locator/locator.dart';
import '../../utils/routes/route_names.dart';

class CinemaDetailsView extends StatefulWidget {
  const CinemaDetailsView({super.key});

  @override
  State<CinemaDetailsView> createState() => _CinemaDetailsViewState();
}

class _CinemaDetailsViewState extends State<CinemaDetailsView> {
  ValueNotifier<String> selectedValue = ValueNotifier("10 Aug");
  List<String> dates = [
    "10 Aug",
    "11 Aug",
    "12 Aug",
    "13 Aug",
    "14 Aug",
    "15 Aug",
    "16 Aug",
    "17 Aug",
    "18 Aug",
    "19 Aug",
    "20 Aug",
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
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 680.h,
              width: 375.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              color: AppColors.lightGreyColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 94.h,
                  ),
                  Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  SizedBox(
                    height: 32.h,
                    width: 330.w,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dates
                          .map(
                            (e) => DateTile(
                              text: e,
                              selectedValue: selectedValue,
                              callback: () {
                                selectedValue.value = e;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 39.h,
                  ),
                  SizedBox(
                    height: 220.h,
                    width: 330.w,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CinemaDatesWidget(),
                        CinemaDatesWidget(),
                        CinemaDatesWidget(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 180.h,
                  ),
                  InkWell(
                    onTap: () {
                      locator<NavService>()
                          .nav
                          .pushNamed(RoutesNames.cinemaSeats);
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
                ],
              ),
            ),
          ],
        ),
      ),
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
