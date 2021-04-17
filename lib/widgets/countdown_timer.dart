import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:spacextracker/providers/launch_provider.dart';

import '../constants.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  @override
  Widget build(BuildContext context) {
    final launch = Provider.of<LaunchProvider>(context).upcomingLaunches[0];
    final countdownTime = launch.dateUnix - DateTime.now().millisecondsSinceEpoch / 1000;
    Duration _duration = Duration(seconds: countdownTime.round());
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Column(
        children: [
          Container(
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('DD', style: TextStyle(color: colorGrey)),
                Text('HH', style: TextStyle(color: colorGrey)),
                Text('MM', style: TextStyle(color: colorGrey)),
                Text('SS', style: TextStyle(color: colorGrey)),
              ],
            ),
          ),
          SlideCountdownClock(
            duration: _duration,
            slideDirection: SlideDirection.Down,
            separator: ':',
            textStyle: TextStyle(
              fontSize: 40,
              color: colorWhite,
              letterSpacing: 2,
            ),
            shouldShowDays: true,
          ),
        ],
      ),
    );
  }
}
