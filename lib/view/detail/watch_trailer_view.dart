import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assement/res/app_colors.dart';
import 'package:tentwenty_assement/utils/locator/locator.dart';
import 'package:tentwenty_assement/utils/nav_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailerView extends StatefulWidget {
  const WatchTrailerView({super.key, required this.url});
  final String url;

  @override
  State<WatchTrailerView> createState() => _WatchTrailerViewState();
}

class _WatchTrailerViewState extends State<WatchTrailerView> {
  final NavService navService = locator<NavService>();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            right: 10.w,
            top: 50.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
              ),
              onPressed: () => locator<NavService>().nav.pop(),
              child: const Text("Done"),
            ),
          ),
          Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
        ],
      ),
    );
  }
}
