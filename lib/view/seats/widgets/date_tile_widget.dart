import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';

class DateTile extends StatelessWidget {
  const DateTile({
    super.key,
    required this.text,
    required this.selectedValue,
    required this.callback,
  });

  final String text;
  final ValueNotifier<String> selectedValue;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: InkWell(
        onTap: callback,
        child: Container(
          height: 32.h,
          width: 67.w,
          decoration: BoxDecoration(
            color: selectedValue.value == text
                ? AppColors.skyBlueColor
                : AppColors.midGreyColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selectedValue.value == text
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
