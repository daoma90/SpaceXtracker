import 'package:flutter/foundation.dart';

class Launch {
  final String id;
  final String name;
  final String rocket;
  final String details;
  final Map launchpad;
  final String stream;
  final String patch;
  final Map payload;
  final int launchNumber;
  final bool upcoming;
  final String datePrecision;
  int dateUnix;
  final String dateReadable;
  final String timeReadable;
  final dynamic success;

  Launch({
    @required this.id,
    @required this.name,
    @required this.rocket,
    this.details,
    @required this.launchpad,
    this.stream,
    @required this.patch,
    this.payload,
    @required this.launchNumber,
    this.upcoming,
    @required this.datePrecision,
    @required this.dateUnix,
    @required this.dateReadable,
    @required this.timeReadable,
    this.success,
  });
}

class Rocket {
  final String rocketId;
  final String rocketName;

  Rocket({
    @required this.rocketId,
    @required this.rocketName,
  });
}

class Payload {
  final String payloadId;
  final String payloadName;
  final String payloadType;
  final String payloadOrbit;
  final String payloadRegime;

  Payload({
    @required this.payloadId,
    @required this.payloadName,
    @required this.payloadType,
    @required this.payloadOrbit,
    @required this.payloadRegime,
  });
}

class Launchpad {
  final String launchpadId;
  final String launchpadName;
  final String launchpadFullName;
  final String launchpadRegion;

  Launchpad({
    @required this.launchpadId,
    @required this.launchpadName,
    @required this.launchpadFullName,
    @required this.launchpadRegion,
  });
}
