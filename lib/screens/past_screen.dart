import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/list_card.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pastLaunches = Provider.of<LaunchProvider>(context).pastLaunches;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 10, top: isPortrait ? 10 : 25),
          itemCount: pastLaunches.length,
          itemExtent: 130,

          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: Container(
                    margin: isPortrait ? null : const EdgeInsets.symmetric(horizontal: 80),
                    child: ListCard(pastLaunches[index]),
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
