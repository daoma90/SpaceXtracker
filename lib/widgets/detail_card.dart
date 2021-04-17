import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/models/launch_models.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'custom_divider.dart';

class DetailCard extends StatelessWidget {
  final Launch launch;
  DetailCard(this.launch);
  @override
  Widget build(BuildContext context) {
    final getRocket = Provider.of<LaunchProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        right: 30,
        bottom: 10,
        left: 30,
      ),
      child: Hero(
        tag: 'card${launch.id}',
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Card(
              color: cardBackground,
              elevation: 10,
              margin: EdgeInsets.only(top: 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          launch.launchNumber.toString(),
                          style: TextStyle(color: colorGrey),
                        ),
                        launch.success != null
                            ? Text(
                                launch.success ? 'Success' : 'Failed',
                                style: TextStyle(color: launch.success ? colorGreen : colorRed, fontSize: 15),
                              )
                            : Text(''),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        launch.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colorWhite, fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      getRocket.getRocket(launch.rocket),
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    ),
                    CustomDivider(),
                    Text(
                      launch.dateReadable,
                      style: TextStyle(color: colorGrey, fontSize: 15),
                    ),
                    Text(
                      launch.timeReadable,
                      style: TextStyle(color: colorGrey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: FadeInImage(
                height: 120,
                width: 120,
                image: launch.patch != null
                    ? NetworkImage(launch.patch)
                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Circle-icons-rocket.svg/1200px-Circle-icons-rocket.svg.png',
                placeholder: MemoryImage(kTransparentImage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
