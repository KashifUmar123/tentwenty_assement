import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assement/res/app_colors.dart';
import 'package:tentwenty_assement/res/app_images.dart';
import 'package:tentwenty_assement/view/home/tabs/movies_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List screens = [
    const MoviesTab(),
  ];

  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(
      icon: Image.asset(
        AppImages.dashboard,
        height: 18,
        width: 18,
      ),
      label: "Dashboard",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        AppImages.watch,
        height: 18,
        width: 18,
      ),
      label: "Watch",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        AppImages.folder,
        height: 18,
        width: 18,
      ),
      label: "Media Liabrary",
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        AppImages.more,
        height: 18,
        width: 18,
      ),
      label: "More",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: screens[0],
      bottomNavigationBar: SizedBox(
        height: 75.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27.r),
            topRight: Radius.circular(27.r),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.blackColor,
            type: BottomNavigationBarType.fixed,
            onTap: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            unselectedLabelStyle: TextStyle(
              fontSize: 10.sp,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w400,
            ),
            selectedLabelStyle: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
            unselectedItemColor: AppColors.greyColor,
            selectedItemColor: AppColors.whiteColor,
            selectedIconTheme: const IconThemeData(color: AppColors.whiteColor),
            items: navigationItems,
          ),
        ),
      ),
    );
  }
}
