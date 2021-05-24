import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/providers/launch_provider.dart';

import '../constants.dart';

class Countdown extends StatefulWidget {
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with WidgetsBindingObserver {
  double countdownTime;
  int _duration;
  CountdownTimerController controller; // Controller for the countdown widget package.
  var countdownOpacity = 0.0;

  // Refactor the countdown timer numbers. Example: if seconds = 1, render 01 instead.
  String refactorTime(int number) {
    if (number == null) return '00';
    return number < 10 ? '0$number' : '$number';
  }

  @override
  void initState() {
    super.initState();

    // Observing App life cycle state. The countdown timer will pause if the app is minimized.
    // If app is minimized and then resumed, the countdown timer has to recalculate the remaining time.
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final launch = context.read<LaunchProvider>().upcomingLaunches[0];
      countdownTime = launch.dateUnix - DateTime.now().millisecondsSinceEpoch / 1000;

      setState(() {
        _duration =
            launch.dateUnix * 1000 - DateTime.now().millisecondsSinceEpoch + DateTime.now().millisecondsSinceEpoch;
        countdownOpacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    // Remove countdown timer controller and app life cycle observer when widget is disposed
    controller.disposeTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If app is resumed, recalculate the remaning time to render.

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (state == AppLifecycleState.resumed) {
        final launch = context.read<LaunchProvider>().upcomingLaunches[0];
        setState(() {
          _duration =
              launch.dateUnix * 1000 - DateTime.now().millisecondsSinceEpoch + DateTime.now().millisecondsSinceEpoch;
        });
      }
    });
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    controller = CountdownTimerController(endTime: _duration);

    return Column(
      children: [
        DelayedDisplay(
          slidingBeginOffset: const Offset(0.0, 0.0),
          delay: Duration(milliseconds: 300),
          child: _duration != null
              ? CountdownTimer(
                  controller: controller,
                  endTime: _duration,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time == null) {
                      return Text('Time for launch!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: colorWhite,
                          ));
                    } else {
                      return Container(
                        width: 60.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: 10.w,
                              child: Text(
                                '${refactorTime(time.days)}',
                                style: TextStyle(fontSize: 25.sp, color: colorWhite, letterSpacing: 2),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 25.sp, color: colorWhite),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 10.w,
                              child: Text(
                                '${refactorTime(time.hours)}',
                                style: TextStyle(fontSize: 25.sp, color: colorWhite, letterSpacing: 2),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 25.sp, color: colorWhite),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 10.w,
                              child: Text(
                                '${refactorTime(time.min)}',
                                style: TextStyle(fontSize: 25.sp, color: colorWhite, letterSpacing: 2),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 25.sp, color: colorWhite),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 10.w,
                              child: Text(
                                '${refactorTime(time.sec)}',
                                style: TextStyle(fontSize: 25.sp, color: colorWhite, letterSpacing: 2),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )
              : null,
        )
      ],
    );
  }
}
