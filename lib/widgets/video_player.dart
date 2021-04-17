import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/widgets/custom_divider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;
  VideoPlayer(this.videoId);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      params: const YoutubePlayerParams(
        startAt: const Duration(minutes: 0, seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
        autoPlay: false,
        mute: false,
      ),
    );

    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {};
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return widget.videoId != null
        ? YoutubePlayerControllerProvider(
            controller: _controller,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Watch the launch',
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: 15,
                    ),
                  ),
                  CustomDivider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Expanded(child: player),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Text(
            'Video not avaliable',
            style: TextStyle(fontSize: 25, color: colorGrey),
          );
  }
}
