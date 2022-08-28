import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorUtils {
  static const Map<int, Color> deepGreenMap = {
    50: Color.fromRGBO(127, 179, 115, 0.1),
    100: Color.fromRGBO(127, 179, 115, 0.2),
    200: Color.fromRGBO(127, 179, 115, 0.3),
    300: Color.fromRGBO(127, 179, 115, 0.4),
    400: Color.fromRGBO(127, 179, 115, 0.5),
    500: Color.fromRGBO(127, 179, 115, 0.6),
    600: Color.fromRGBO(127, 179, 115, 0.7),
    700: Color.fromRGBO(127, 179, 115, 0.8),
    800: Color.fromRGBO(127, 179, 115, 0.9),
    900: Color.fromRGBO(127, 179, 115, 1),
  };

  static const MaterialColor deepGreen =
      MaterialColor(0xFF7FB373, deepGreenMap);
}

class WaypointUtils {
  // WAYPOINT STRUCTURE: "name1:lat|long,name2:lat|long"
  // GENERAL INFO: Names are unique identifiers

  static List<String> getWaypoints(SharedPreferences sharedPreferences) {
    String waypoints = sharedPreferences.getString('waypoints') ?? '';

    List<String> waypointList = waypoints.split(",");

    return waypointList;
  }

  static Future<bool> addWaypoint(
      String name, Position location, SharedPreferences sharedPreferences) {
    String waypoints = sharedPreferences.getString('waypoints') ?? '';

    if (getWaypoints(sharedPreferences).isNotEmpty) {
      waypoints += "," +
          name +
          ":" +
          location.latitude.toString() +
          "|" +
          location.longitude.toString();
    } else {
      waypoints += name +
          ":" +
          location.latitude.toString() +
          "|" +
          location.longitude.toString();
    }

    return sharedPreferences.setString('waypoints', waypoints);
  }

  static Future<bool> clearWaypoints(SharedPreferences sharedPreferences) {
    return sharedPreferences.setString('waypoints', '');
  }

  static double getWaypointLatitude(String waypoint) {
    return double.parse(waypoint.split(":")[1].split("|")[0]);
  }

  static double getWaypointLongitude(String waypoint) {
    // print(waypoint.split("|")[1]);
    return double.parse(waypoint.split("|")[1]);
  }

  static Position getWaypointPosition(String waypoint) {

    print(waypoint);

    return Position.fromMap({
      'latitude': getWaypointLatitude(waypoint),
      'longitude': getWaypointLongitude(waypoint),
    });
  }

  static String getWaypointName(String waypoint) {
    return waypoint.split(":")[0];
  }

  static Future<bool> removeWaypoint(String waypoint, SharedPreferences sharedPreferences) {
    List<String> waypointList = getWaypoints(sharedPreferences);

    for (var w in waypointList) {
      if (w == waypoint) {
        waypointList.remove(w);
      }
    }

    return sharedPreferences.setString('waypoints', waypointList.join());
  }
}
