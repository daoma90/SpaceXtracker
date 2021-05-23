import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:spacextracker/constants.dart';
import 'package:spacextracker/models/launch_models.dart';
import 'package:spacextracker/widgets/custom_divider.dart';
import 'package:transparent_image/transparent_image.dart';

class ListCard extends StatelessWidget {
  final Launch launch;

  ListCard(this.launch);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(
        top: 6,
        right: width > 1500
            ? 50.w
            : width > 500
                ? 20.w
                : 15,
        bottom: 6,
        left: width > 1500
            ? 50.w
            : width > 500
                ? 20.w
                : 15,
      ),
      child: Hero(
        tag: 'card${launch.id}',
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Card(
              elevation: 10,
              color: cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.only(left: 32),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  Navigator.of(context).pushNamed('/details', arguments: launch);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15, right: 15, bottom: 15, left: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          alignment: Alignment.centerLeft,
                          // width: width > 600 ? 190 : 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                launch.name,
                                style: TextStyle(color: colorWhite, fontSize: 15),
                              ),
                              CustomDivider(),
                              Text(
                                launch.rocket,
                                style: TextStyle(color: colorGrey, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // width > 350
                      //     ? Column(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           launch.success != null
                      //               ? Text(
                      //                   launch.success ? 'Success' : 'Failed',
                      //                   style: TextStyle(color: launch.success ? colorGreen : colorRed, fontSize: 15),
                      //                 )
                      //               : Text(''),
                      //           Column(
                      //             children: [
                      //               Text(
                      //                 launch.dateReadable,
                      //                 style: TextStyle(color: colorGrey, fontSize: 12),
                      //               ),
                      //               Text(
                      //                 launch.timeReadable,
                      //                 style: TextStyle(color: colorGrey, fontSize: 12),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       )
                      //     : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 0.5,
              child: FadeInImage.memoryNetwork(
                height: 65,
                width: 65,
                image: launch.patch != null
                    ? launch.patch
                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Circle-icons-rocket.svg/1200px-Circle-icons-rocket.svg.png',
                placeholder: kTransparentImage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
