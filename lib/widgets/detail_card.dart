import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/models/launch_models.dart';
import 'package:transparent_image/transparent_image.dart';
import 'custom_divider.dart';

class DetailCard extends StatelessWidget {
  final Launch launch;
  DetailCard(this.launch);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        right: 20,
        bottom: 10,
        left: 20,
      ),
      child: Hero(
        tag: 'card${launch.id}',
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              constraints: width > 500 ? BoxConstraints(maxWidth: 50.w) : null,
              margin: EdgeInsets.only(top: 70, right: 10, bottom: 10, left: 10),
              decoration: BoxDecoration(
                color: cardBackground.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [cardShadow],
              ),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
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
                    SizedBox(height: 25),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        launch.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colorWhite, fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      launch.rocket,
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
              top: 10,
              child: FadeInImage.memoryNetwork(
                height: 120,
                width: 120,
                image: launch.patch != null
                    ? launch.patch
                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Circle-icons-rocket.svg/1200px-Circle-icons-rocket.svg.png',
                placeholder: kTransparentImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
