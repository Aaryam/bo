import 'dart:async';
import 'dart:math';

import 'package:bo/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage(
      {Key? key,
      required this.title,
      required this.tag,
      required this.destination})
      : super(key: key);

  final String title;
  final String tag;
  final Position destination;

  @override
  State<NavigatePage> createState() => NavigatePageState();
}

class NavigatePageState extends State<NavigatePage> {
  Position currentLoc = Position.fromMap({
    'latitude': 0.0,
    'longitude': 0.0,
  });

  Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, distanceFilter: 1));

  double distance = 0.0;
  double bearing = 0.0;

  @override
  void dispose() {
    positionStream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    positionStream.listen((Position position) {
      currentLoc = position;
      if (mounted) {
        setState(() {
          distance = Geolocator.distanceBetween(
              currentLoc.latitude,
              currentLoc.longitude,
              widget.destination.latitude,
              widget.destination.longitude);
          bearing = Geolocator.bearingBetween(
              currentLoc.latitude,
              currentLoc.longitude,
              widget.destination.latitude,
              widget.destination.longitude);
        });
      }
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
              StreamBuilder<CompassEvent>(
                stream: FlutterCompass.events,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double? direction = snapshot.data!.heading! + bearing;
                    return Center(
                      child: Transform.rotate(
                        angle: (direction * (pi / 180) * -1),
                        child: GestureDetector(
                          onTap: () async {
                            if (mounted) {
                              currentLoc =
                                  await Geolocator.getCurrentPosition();
                            }
                            print(currentLoc);
                          },
                          child: Image.asset('assets/images/cool.png'),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(20),
              ),
              Text(distance.toStringAsFixed(2) + ' m',
                  style: TextStyle(
                    fontSize: 20,
                  )),
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
