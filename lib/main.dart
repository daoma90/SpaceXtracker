// import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import './screens/rocket_screen.dart';
import './screens/search_screen.dart';
import './constants.dart';
import './screens/detail_screen.dart';
import './screens/loading_screen.dart';
import './screens/tab_screen.dart';
import './providers/launch_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

// Main widget of the app. App starts here.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrapping app with provider. All widgets will have access to the data stored in the provider.
    return ChangeNotifierProvider(
      create: (context) => LaunchProvider(),
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'SpaceXTracker',
          theme: ThemeData(
            fontFamily: 'Oswald',
            primaryColor: barColor,
            scaffoldBackgroundColor: scaffoldColor,
          ),
          initialRoute: '/',
          routes: {
            // App routes
            '/': (context) => LoadingScreen(),
            '/main': (context) => TabScreen(),
            '/details': (context) => DetailScreen(),
            '/search': (context) => SearchScreen(),
            '/rocket': (context) => RocketScreen(),
          },
        );
      }),
    );
  }
}
