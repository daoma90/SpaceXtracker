import 'package:flutter/material.dart';

import 'package:spacextracker/constants.dart';
import 'package:spacextracker/models/launch_models.dart';

import 'package:spacextracker/widgets/detail_card.dart';
import 'package:spacextracker/widgets/detail_text_section.dart';
import 'package:spacextracker/widgets/video_player.dart';

// class DetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final launch = ModalRoute.of(context).settings.arguments as Launch;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Image(
//                     height: 350,
//                     width: double.infinity,
//                     image: AssetImage('assets/images/rocket-trail.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                   Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [Colors.black, scaffoldColor],
//                           stops: [0.2, 0.9]),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: launch.name.length > 27 ? 125 : 100, right: 30, bottom: 30, left: 30),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         DetailsTextSection(
//                           title: 'Details',
//                           text: launch.details,
//                         ),
//                         DetailsTextSection(
//                           title: 'Payload',
//                           list: launch.payload,
//                         ),
//                         DetailsTextSection(
//                           title: 'Target',
//                           list: launch.payload,
//                         ),
//                         DetailsTextSection(
//                           title: 'Launchpad',
//                           list: launch.launchpad,
//                         ),
//                         launch.stream != null ? VideoPlayer(launch.stream) : SizedBox(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 210),
//                 child: DetailCard(launch),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final launch = ModalRoute.of(context).settings.arguments as Launch;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
              padding: EdgeInsets.only(top: launch.name.length >= 24 ? 165 : 140, right: 30, bottom: 30, left: 30),
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
