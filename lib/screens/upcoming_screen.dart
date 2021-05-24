import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/list_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class UpcomingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final upcomingLaunches = Provider.of<LaunchProvider>(context).upcomingLaunches;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: isPortrait ? 10 : 25),
          itemExtent: 130,
          itemCount: upcomingLaunches.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 100,
                child: FadeInAnimation(
                  child: Container(
                    margin: isPortrait ? null : const EdgeInsets.symmetric(horizontal: 80),
                    child: ListCard(upcomingLaunches[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
