import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/launch_models.dart';

class LaunchProvider with ChangeNotifier {
  List<Launch> _upcomingLaunches = [];

  List<Launch> get upcomingLaunches {
    return [..._upcomingLaunches];
  }

  List<Launch> _pastLaunches = [];

  List<Launch> get pastLaunches {
    return [..._pastLaunches];
  }

  List<Rocket> _rockets = [];

  List<Rocket> get rockets {
    return [..._rockets];
  }

  List<Payload> _payloads = [];

  List<Payload> get payloads {
    return [..._payloads];
  }

  List<Launchpad> _launchpads = [];

  List<Launchpad> get launchpads {
    return [..._launchpads];
  }

  String dateFormatter(String datePrecision, int time) {
    String formattedDate;
    if (datePrecision == 'hour' || datePrecision == 'day') {
      formattedDate = DateFormat.yMMMd('en_US').format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
    } else if (datePrecision == 'month' || datePrecision == 'quarter') {
      formattedDate = DateFormat.yMMM('en_US').format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
    } else if (datePrecision == 'year') {
      formattedDate = DateFormat.y('en_US').format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
    }

    return formattedDate;
  }

  String timeFormatter(String datePrecision, int time) {
    String formattedTime;
    if (datePrecision == 'hour') {
      formattedTime = DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(time * 1000)) + " GMT";
    } else {
      formattedTime = "N/A";
    }
    return formattedTime;
  }

  Future<void> fetchAndSetUpcomingLaunches() async {
    final url = 'https://api.spacexdata.com/v4/launches/upcoming';

    try {
      final response = await http.get(Uri.parse(url));
      final fetchData = json.decode(response.body) as List<dynamic>;

      final List<Launch> upcomingLaunches = [];
      if (fetchData == null) {
        return;
      }

      fetchData.forEach((launch) {
        upcomingLaunches.add(Launch(
          id: launch['id'],
          name: launch['name'],
          rocket: getRocket(launch['rocket']).rocketName,
          details: launch['details'] != null ? launch['details'] : 'N/A',
          launchpad: getLaunchpad(launch['launchpad']),
          patch: launch['links']['patch']['small'],
          payload: getPayload(launch['payloads']),
          launchNumber: launch['flight_number'],
          datePrecision: launch['date_precision'],
          dateUnix: launch['date_unix'],
          dateReadable: dateFormatter(launch['date_precision'], launch['date_unix']),
          timeReadable: timeFormatter(launch['date_precision'], launch['date_unix']),
        ));
      });

      _upcomingLaunches = upcomingLaunches;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetPastLaunches() async {
    final url = 'https://api.spacexdata.com/v4/launches/past';

    try {
      final response = await http.get(Uri.parse(url));
      final fetchData = json.decode(response.body) as List<dynamic>;
      final List<Launch> pastLaunches = [];
      if (fetchData == null) {
        return;
      }

      fetchData.forEach((launch) {
        pastLaunches.add(Launch(
          id: launch['id'],
          name: launch['name'],
          rocket: getRocket(launch['rocket']).rocketName,
          details: launch['details'],
          launchpad: getLaunchpad(launch['launchpad']),
          patch: launch['links']['patch']['small'],
          payload: getPayload(launch['payloads']),
          launchNumber: launch['flight_number'],
          datePrecision: launch['date_precision'],
          dateUnix: launch['date_unix'],
          stream: launch['links']['youtube_id'],
          dateReadable:
              DateFormat.yMMMd('en_US').format(DateTime.fromMillisecondsSinceEpoch(launch['date_unix'] * 1000)),
          timeReadable:
              DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(launch['date_unix'] * 1000)) + ' GMT',
          success: launch['success'],
        ));
      });

      _pastLaunches = pastLaunches.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetRockets() async {
    final url = 'https://api.spacexdata.com/v4/rockets';

    try {
      final response = await http.get(Uri.parse(url));
      final fetchData = json.decode(response.body) as List<dynamic>;
      final List<Rocket> fetchedRockets = [];
      if (fetchData == null) {
        return;
      }

      fetchData.forEach((rocket) {
        fetchedRockets.add(Rocket(
          rocketId: rocket['id'],
          rocketName: rocket['name'],
          details: rocket['description'],
          height: rocket['height']['meters'],
          diameter: rocket['diameter']['meters'],
          mass: rocket['mass']['kg'],
          engine: rocket['engines']['type'],
          payloadToLeo: rocket['payload_weights'][0]['kg'],
          payloadToGto: rocket['payload_weights'].length > 1 ? rocket['payload_weights'][1]['kg'] : 0,
          payloadToMars: rocket['payload_weights'].length > 2 ? rocket['payload_weights'][2]['kg'] : 0,
          payloadWeights: rocket['payload_weights'],
        ));
      });

      _rockets = fetchedRockets;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetPayloads() async {
    final url = 'https://api.spacexdata.com/v4/payloads';

    try {
      final response = await http.get(Uri.parse(url));
      final fetchData = json.decode(response.body) as List<dynamic>;
      final List<Payload> fetchedPayloads = [];
      if (fetchData == null) {
        return;
      }

      fetchData.forEach((payload) {
        fetchedPayloads.add(Payload(
          payloadId: payload['id'],
          payloadName: payload['name'],
          payloadType: payload['type'],
          payloadOrbit: payload['orbit'],
          payloadRegime: payload['regime'],
        ));
      });

      _payloads = fetchedPayloads;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetLaunchpads() async {
    final url = 'https://api.spacexdata.com/v4/launchpads';

    try {
      final response = await http.get(Uri.parse(url));
      final fetchData = json.decode(response.body) as List<dynamic>;
      final List<Launchpad> fetchedLaunchpads = [];
      if (fetchData == null) {
        return;
      }

      fetchData.forEach((launchpad) {
        fetchedLaunchpads.add(Launchpad(
            launchpadId: launchpad['id'],
            launchpadName: launchpad['name'],
            launchpadFullName: launchpad['full_name'],
            launchpadRegion: launchpad['region']));
      });

      _launchpads = fetchedLaunchpads;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Rocket getRocket(String rocketId) {
    Rocket rocketToReturn;

    _rockets.forEach((rocket) {
      if (rocket.rocketId == rocketId) {
        rocketToReturn = rocket;
      }
    });

    return rocketToReturn;
  }

  Map<String, String> getPayload(List launchPayloadId) {
    Map<String, String> payloadList;

    _payloads.forEach((payload) {
      launchPayloadId.forEach((payloadId) {
        if (payload.payloadId == payloadId) {
          payloadList = {
            'payloadName': payload.payloadName,
            'payloadType': payload.payloadType,
            'payloadOrbit': payload.payloadOrbit,
            'payloadRegime': payload.payloadRegime,
          };
        }
      });
    });

    return payloadList;
  }

  Map<String, String> getLaunchpad(String launchLaunchpadId) {
    Map<String, String> launchpadList;

    _launchpads.forEach((launchpad) {
      if (launchpad.launchpadId == launchLaunchpadId) {
        launchpadList = {
          'launchpadId': launchpad.launchpadId,
          'launchpadName': launchpad.launchpadName,
          'launchpadFullName': launchpad.launchpadFullName,
          'launchpadRegion': launchpad.launchpadRegion,
        };
      }
    });

    return launchpadList;
  }

  List<Launch> filterLaunches(String searchInput) {
    List<Launch> allLaunches = [..._upcomingLaunches, ..._pastLaunches];
    List<Launch> filteredLaunches = [];

    if (searchInput.length > 0) {
      allLaunches.forEach((launch) => {
            if (launch.details != null && launch.details.toLowerCase().contains(searchInput) ||
                launch.dateReadable != null && launch.dateReadable.toLowerCase().contains(searchInput) ||
                launch.name != null && launch.name.toLowerCase().contains(searchInput) ||
                launch.rocket != null && launch.rocket.toLowerCase().contains(searchInput))
              {filteredLaunches.add(launch)}
          });
    }

    return filteredLaunches;
  }
}

// (launch.success != null  && searchInput == 'success') ||
//                 (launch.success != null && searchInput == 'failed') ||
