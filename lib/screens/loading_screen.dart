import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/providers/launch_provider.dart';

// import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLaunchData();
  }

  void getLaunchData() async {
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetRockets();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetPayloads();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetLaunchpads();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetUpcomingLaunches();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetPastLaunches();
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/RocketIcon.png'),
          height: 140,
          width: 140,
        ),
      ),
    );
  }
}
