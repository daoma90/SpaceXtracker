import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/screens/search_screen.dart';
import './constants.dart';
import './screens/detail_screen.dart';
import './screens/loading_screen.dart';
import './screens/tab_screen.dart';
import './providers/launch_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LaunchProvider(),
      child: MaterialApp(
        title: 'SpaceXTracker',
        theme: ThemeData(
          primaryColor: barColor,
          scaffoldBackgroundColor: scaffoldColor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoadingScreen(),
          '/main': (context) => TabScreen(),
          '/details': (context) => DetailScreen(),
          '/search': (context) => SearchScreen(),
        },
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('Launches'),
//         ),
//       ),
//       body: Center(
//         child: Text('Body'),
//       ),
//     );
//   }
// }
