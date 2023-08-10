import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/movie_search_status.dart';
import '../../../view_model/movies_view_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.isSearchOpen,
  });

  final ValueNotifier<bool> isSearchOpen;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late MoviesViewModel upcomingMoviesViewModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    upcomingMoviesViewModel = Provider.of<MoviesViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.5.w),
      child: Container(
        width: 334.w,
        height: 52.h,
        decoration: widget.isSearchOpen.value
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.lightGreyColor,
              )
            : null,
        child: widget.isSearchOpen.value
            ? SizedBox(
                width: 334.w,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    const Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 195.w,
                      height: 40.h,
                      child: TextField(
                        onChanged: (val) {
                          if (val == "") {
                            upcomingMoviesViewModel.setMovieSearchStatus(
                                MoiveSearchStatus.SearchClicked);
                          } else {
                            upcomingMoviesViewModel.setMovieSearchStatus(
                                MoiveSearchStatus.SearchActiveTyping);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "TV shows, movies and more",
                          hintStyle: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14.sp,
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            widget.isSearchOpen.value =
                                !widget.isSearchOpen.value;
                            if (widget.isSearchOpen.value == true) {
                              log("true");
                              upcomingMoviesViewModel.setMovieSearchStatus(
                                  MoiveSearchStatus.SearchClicked);
                            } else if (!widget.isSearchOpen.value) {
                              upcomingMoviesViewModel.setMovieSearchStatus(
                                  MoiveSearchStatus.SearchNotCliecked);
                              log(upcomingMoviesViewModel.currentSearchStatus
                                  .toString());
                            }
                          },
                        );
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Watch",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.isSearchOpen.value = !widget.isSearchOpen.value;
                      if (widget.isSearchOpen.value == true) {
                        log("true");
                        upcomingMoviesViewModel.setMovieSearchStatus(
                            MoiveSearchStatus.SearchClicked);
                        log(upcomingMoviesViewModel.currentSearchStatus
                            .toString());
                      } else if (!widget.isSearchOpen.value) {
                        log("false");
                        upcomingMoviesViewModel.setMovieSearchStatus(
                            MoiveSearchStatus.SearchNotCliecked);
                        log(upcomingMoviesViewModel.currentSearchStatus
                            .toString());
                      }
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
