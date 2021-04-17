import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/models/launch_models.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/detail_card.dart';
import 'package:spacextracker/widgets/detail_text_section.dart';
import 'package:spacextracker/widgets/video_player.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final launchData = Provider.of<LaunchProvider>(context);
    final launch = ModalRoute.of(context).settings.arguments as Launch;

    return Scaffold(
      // backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image(
                    height: 350,
                    width: double.infinity,
                    image: AssetImage('assets/images/rocket-trail.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, scaffoldColor],
                          stops: [0.2, 0.9]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100, right: 30, bottom: 30, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DetailsTextSection(
                          title: 'Details',
                          text: launch.details,
                        ),
                        DetailsTextSection(
                          title: 'Payload',
                          list: launchData.getPayload(launch.payload[0]),
                        ),
                        DetailsTextSection(
                          title: 'Target',
                          list: launchData.getPayload(launch.payload[0]),
                        ),
                        DetailsTextSection(
                          title: 'Launchpad',
                          list: launchData.getLaunchpad(launch.launchpad),
                        ),
                        launch.stream != null ? VideoPlayer(launch.stream) : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 210),
                child: DetailCard(launch),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
