import 'dart:async';

import 'package:bo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key, required this.title, required this.tag})
      : super(key: key);

  final String title;
  final String tag;

  @override
  State<NavigatePage> createState() => NavigatePageState();
}

class NavigatePageState extends State<NavigatePage> {
  Position destLoc = Position.fromMap({
    'latitude': 0.0,
    'longitude': 0.0,
  });

  Position currentLoc = Position.fromMap({
    'latitude': 0.0,
    'longitude': 0.0,
  });

  Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0));

  @override
  Widget build(BuildContext context) {
    positionStream.listen((Position position) {
      currentLoc = position;
    });

    return Scaffold(
      body: Hero(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RotationTransition(
                turns: const AlwaysStoppedAnimation(90 / 360),
                child: Image.asset('assets/images/cool.png'),
              ),
              Text(Geolocator.distanceBetween(currentLoc.latitude,
                      currentLoc.longitude, destLoc.latitude, destLoc.longitude)
                  .toString()),
            ],
          ),
        ),
        tag: widget.tag,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: ColorUtils.deepGreen,
        elevation: 0,
      ),
    );
  }
}
