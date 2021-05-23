import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/main_drawer.dart';
import '../constants.dart';
import '../screens/past_screen.dart';
import '../screens/upcoming_screen.dart';
import '../screens/home_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with WidgetsBindingObserver {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (state == AppLifecycleState.resumed) {
        print('resumed');
        getLaunchData();
        setState(() {});
      }
    });
    super.didChangeAppLifecycleState(state);
  }

  void getLaunchData() async {
    print('getting data');
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetRockets();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetPayloads();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetLaunchpads();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetUpcomingLaunches();
    await Provider.of<LaunchProvider>(context, listen: false).fetchAndSetPastLaunches();
    print('data finished');
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      extendBodyBehindAppBar: isPortrait ? false : true,
      appBar: AppBar(
        title: isPortrait
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(_tabScreens[_selectedScreenIndex]['title']),
              )
            : null,
        elevation: isPortrait ? 5 : 0,
        centerTitle: isPortrait ? true : false,
        backgroundColor: isPortrait ? null : Colors.transparent,
        toolbarHeight: 45,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.of(context).pushNamed('/search');
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 5.0, right: 6.0, left: 6.0),
                child: Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
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
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Upcoming'),
          const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Past'),
        ],
      ),
    );
  }
}
