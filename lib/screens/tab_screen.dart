import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../constants.dart';
import '../screens/past_screen.dart';
import '../screens/upcoming_screen.dart';
import '../screens/home_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _tabScreens = [
    {'page': HomeScreen(), 'title': 'Home'},
    {'page': UpcomingScreen(), 'title': 'Upcoming launches'},
    {'page': PastScreen(), 'title': 'Past launches'},
  ];
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    Feedback.forTap(context);
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      extendBodyBehindAppBar: isPortrait ? false : true,
      appBar: AppBar(
        title: isPortrait ? Text(_tabScreens[_selectedScreenIndex]['title']) : null,
        elevation: isPortrait ? 5 : 0,
        centerTitle: isPortrait ? true : false,
        backgroundColor: isPortrait ? null : Colors.transparent,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.of(context).pushNamed('/search');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
      body: _tabScreens[_selectedScreenIndex]['page'],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.rectangle,
        snakeViewColor: tabActive,
        onTap: _selectScreen,
        backgroundColor: barColor,
        selectedItemColor: colorWhite,
        unselectedItemColor: colorGrey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: _selectedScreenIndex,
        height: 61,
        items: [
          // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Upcoming'),
          // BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Past'),
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Upcoming'),
          const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Past'),
          // TabItem(icon: Icons.home, title: 'Home'),
          // TabItem(icon: Icons.access_time, title: 'Upcoming'),
          // TabItem(icon: Icons.history, title: 'Past'),
        ],
      ),
    );
  }
}
