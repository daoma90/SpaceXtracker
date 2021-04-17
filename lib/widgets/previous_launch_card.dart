import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/providers/launch_provider.dart';
import 'package:spacextracker/widgets/custom_divider.dart';

class PreviousLaunchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pastLaunch = Provider.of<LaunchProvider>(context).pastLaunches[0];
    final getRocket = Provider.of<LaunchProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        right: 30,
        bottom: 10,
        left: 30,
      ),
      width: double.infinity,
      child: Hero(
        tag: 'card${pastLaunch.id}',
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Card(
              color: Color(0xFF424567),
              elevation: 10,
              margin: EdgeInsets.only(top: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/details', arguments: pastLaunch);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            pastLaunch.launchNumber.toString(),
                            style: TextStyle(color: colorGrey),
                          ),
                          Text(
                            pastLaunch.success ? 'Success' : 'Failed',
                            style: TextStyle(color: pastLaunch.success ? colorGreen : colorRed),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Previous launch',
                        style: TextStyle(color: colorGrey, fontSize: 17),
                      ),
                      SizedBox(height: 5),
                      Text(
                        pastLaunch.name,
                        style: TextStyle(color: colorWhite, fontSize: 25),
                      ),
                      SizedBox(height: 5),
                      Text(
                        getRocket.getRocket(pastLaunch.rocket),
                        style: TextStyle(color: colorGrey, fontSize: 20),
                      ),
                      CustomDivider(),
                      Text(
                        pastLaunch.dateReadable,
                        style: TextStyle(color: colorGrey, fontSize: 15),
                      ),
                      Text(
                        '${pastLaunch.timeReadable} GMT',
                        style: TextStyle(color: colorGrey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -10,
              child: FadeInImage.memoryNetwork(
                height: 120,
                width: 120,
                image: pastLaunch.patch,
                placeholder: kTransparentImage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
