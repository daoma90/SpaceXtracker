import 'package:flutter/material.dart';
import '../widgets/previous_launch_card.dart';
import '../widgets/next_launch_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 25),
          child: Column(
            children: <Widget>[
              NextLaunchCard(),
              PreviousLaunchCard(),
            ],
          ),
        ),
      ),
    );
  }
}
