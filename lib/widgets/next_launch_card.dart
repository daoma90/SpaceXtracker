import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/countdown_timer.dart';
import 'package:spacextracker/widgets/custom_divider.dart';
import 'package:transparent_image/transparent_image.dart';

class NextLaunchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nextLaunch = Provider.of<LaunchProvider>(context).upcomingLaunches[0];

    return Container(
      padding: EdgeInsets.only(
        top: 30,
        right: 20,
        bottom: 10,
        left: 20,
      ),
      width: double.infinity,
      child: Hero(
        tag: 'card${nextLaunch.id}',
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: 500),
              margin: EdgeInsets.only(top: 50, right: 10, bottom: 10, left: 10),
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [cardShadow],
              ),
              child: Card(
                elevation: 0,
                color: cardBackground,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/details', arguments: nextLaunch);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              nextLaunch.launchNumber.toString(),
                              style: TextStyle(color: colorGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Next launch',
                          style: TextStyle(color: colorGrey, fontSize: 17),
                        ),
                        Container(
                          // height: 100,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          color: cardBackground,
                          // color: Colors.amber,
                          child: nextLaunch.datePrecision == 'hour'
                              ? Countdown()
                              : Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    'Launch time not avaliable :(',
                                    style: TextStyle(fontSize: 25, color: colorGrey),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                        Text(
                          nextLaunch.name,
                          style: TextStyle(color: colorWhite, fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          nextLaunch.rocket,
                          style: TextStyle(color: colorGrey, fontSize: 20),
                        ),
                        CustomDivider(),
                        Text(
                          nextLaunch.dateReadable,
                          style: TextStyle(color: colorGrey, fontSize: 15),
                        ),
                        Text(
                          nextLaunch.timeReadable,
                          style: TextStyle(color: colorGrey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -10,
              child: FadeInImage.memoryNetwork(
                height: 120,
                width: 120,
                image: nextLaunch.patch,
                placeholder: kTransparentImage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
