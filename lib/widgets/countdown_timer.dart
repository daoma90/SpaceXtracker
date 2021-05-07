import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
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
  CountdownTimerController controller;
  var countdownOpacity = 0.0;

  String refactorTime(int number) {
    if (number == null) return '00';
    return number < 10 ? '0$number' : '$number';
  }

  @override
  void initState() {
    super.initState();
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
    controller.disposeTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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

    return Container(
      padding: const EdgeInsets.only(top: 10),
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
          DelayedDisplay(
            slidingBeginOffset: const Offset(0.0, 0.0),
            delay: Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: _duration != null
                  ? CountdownTimer(
                      controller: controller,
                      endTime: _duration,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return Text('Time for launch!', style: TextStyle(fontSize: 40, color: colorWhite));
                        } else {
                          return Text(
                            '${refactorTime(time.days)}:${refactorTime(time.hours)}:${refactorTime(time.min)}:${refactorTime(time.sec)}',
                            style: TextStyle(fontSize: 46, color: colorWhite, letterSpacing: 2),
                          );
                        }
                      },
                    )
                  : null,
              // : Text('', style: TextStyle(fontSize: 46, color: colorWhite, letterSpacing: 2)),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CountdownTimer extends StatefulWidget {
//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }

// class _CountdownTimerState extends State<CountdownTimer> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
//   double countdownTime;
//   Duration _duration;
//   Animation _animation;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       watch.start();
//       setState(() {
//         _duration = Duration(days: 1); //Duration set to days 1 on initState for testing purposes
//       });
//     });
//     _animationController = AnimationController(
//       duration: Duration(seconds: 100),
//       vsync: this,
//     );

//     _animation = new CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.linear,
//     )..addStatusListener((AnimationStatus status) {
//         if (status == AnimationStatus.completed) {
//           _animationController.reset();
//           _animationController.forward();
//         }
//       });
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       //I want to update the timer when app is resumed
//       if (state == AppLifecycleState.resumed) {
//         print('App Resumed');
//         setState(() {
//           print('App life cycle resume duration $_duration}');
//         });
//       }
//     });
//     super.didChangeAppLifecycleState(state);
//   }

//   AnimationController _animationController;
//   Stopwatch watch = Stopwatch();
//   @override
//   Widget build(BuildContext context) {
//     print('Build run with duration $_duration');
//     return Container(
//       padding: const EdgeInsets.only(top: 10, bottom: 5),
//       child: Column(
//         children: [
//           Container(
//             width: 220,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('DD', style: TextStyle(color: Colors.grey)),
//                 Text('HH', style: TextStyle(color: Colors.grey)),
//                 Text('MM', style: TextStyle(color: Colors.grey)),
//                 Text('SS', style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//           AnimatedBuilder(
//               animation: _animation, builder: (_duration, Widget child) => Text(watch.elapsed.inSeconds.toString()))
//         ],
//       ),
//     );
//   }
// }
