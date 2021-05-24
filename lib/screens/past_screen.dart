import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/list_card.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Taking data from the provider
    final pastLaunches = Provider.of<LaunchProvider>(context).pastLaunches;
    // Checking if app is in portrait mode.
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: AnimationLimiter(
        // The Listview builder can build a list where only the list items visible are rendered.
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: isPortrait ? 10 : 25),
          itemCount: pastLaunches.length,
          itemExtent: 130,
          itemBuilder: (context, index) {
            // Using a package to animate list items one by one with a short delay.
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
