import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  final String rocketName;
  VideoBackground(this.rocketName);

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> with WidgetsBindingObserver {
  VideoPlayerController _controller;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/videos/${widget.rocketName.replaceAll(' ', '')}.webm")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);

        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (state == AppLifecycleState.resumed) {
        _controller.play();
      } else if (state == AppLifecycleState.paused) {
        _controller.pause();
      }
    });
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment(width > 500 ? -0.05 : 0.03, 0),
        child: SizedBox(
          width: _controller.value.size?.width ?? 0,
          height: _controller.value.size?.height ?? 0,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
