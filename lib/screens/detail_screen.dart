import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/models/launch_models.dart';

import 'package:spacextracker/widgets/detail_card.dart';
import 'package:spacextracker/widgets/detail_text_section.dart';
import 'package:spacextracker/widgets/video_player.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final launch = ModalRoute.of(context).settings.arguments as Launch;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: width > 500
          ? DetailScreenLarge(launch: launch)
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Image(
                      alignment: Alignment(-0.1, -0.4),
                      height: 380,
                      width: double.infinity,
                      image: AssetImage('assets/images/spacex-launch.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: launch.name.length > 33 ? 200 : 170, right: 30, bottom: 30, left: 30),
                    margin: EdgeInsets.only(top: 320),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [scaffoldColor.withOpacity(0), scaffoldColor.withOpacity(0.5), scaffoldColor],
                          stops: [0.01, 0.025, 0.05]),
                    ),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DetailsTextSection(
                            title: 'Details',
                            text: launch.details,
                          ),
                          DetailsTextSection(
                            title: 'Payload',
                            list: launch.payload,
                          ),
                          DetailsTextSection(
                            title: 'Target',
                            list: launch.payload,
                          ),
                          DetailsTextSection(
                            title: 'Launchpad',
                            list: launch.launchpad,
                          ),
                          launch.stream != null ? VideoPlayer(launch.stream) : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    left: 0,
                    right: 0,
                    child: Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(top: 210),
                      child: DetailCard(launch),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class DetailScreenLarge extends StatelessWidget {
  const DetailScreenLarge({
    Key key,
    @required this.launch,
  }) : super(key: key);

  final Launch launch;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image(
            alignment: Alignment(0, 0),
            height: 100.h,
            width: double.infinity,
            image: AssetImage('assets/images/spacex-launch.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 300),
                  child: DetailCard(launch),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 100, left: 30),
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DetailsTextSection(
                        title: 'Details',
                        text: launch.details,
                      ),
                      DetailsTextSection(
                        title: 'Payload',
                        list: launch.payload,
                      ),
                      DetailsTextSection(
                        title: 'Target',
                        list: launch.payload,
                      ),
                      DetailsTextSection(
                        title: 'Launchpad',
                        list: launch.launchpad,
                      ),
                      launch.stream != null ? VideoPlayer(launch.stream) : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
