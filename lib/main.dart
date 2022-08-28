import 'package:bo/pages/startpage.dart';
import 'package:bo/widgets/addwaypointdialog.dart';
import 'package:bo/widgets/detailscard.dart';
import 'package:flutter/material.dart';
import 'package:bo/misc/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'misc/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final addWaypointController = TextEditingController();

  Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, distanceFilter: 1));

  Position currentLoc = Position.fromMap({
    'latitude': 0.0,
    'longitude': 0.0,
  });

  @override
  void dispose() {
    positionStream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    positionStream.listen((Position position) {
      if (mounted) {
        currentLoc = position;
      }
    });

    return Scaffold(
      body: RefreshIndicator(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Search a waypoint',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  onChanged: (val) async {
                    WaypointUtils.clearWaypoints(
                        await SharedPreferences.getInstance());
                  },
                ),
              ),
              FutureBuilder<Position>(builder: (locationContext, initialCurrentPos) {
                if (initialCurrentPos.hasData &&
                    initialCurrentPos.connectionState == ConnectionState.done) {
                      currentLoc = initialCurrentPos.data ?? currentLoc;
                  return FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (prefContext, sharedPreferences) {
                      if (sharedPreferences.connectionState ==
                              ConnectionState.done &&
                          sharedPreferences.hasData) {
                        int waypointCount = WaypointUtils.getWaypoints(
                                sharedPreferences.data as SharedPreferences)
                            .length;

                        return Container(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, currentWaypointIndex) {
                              String waypoint = WaypointUtils.getWaypoints(
                                      sharedPreferences.data
                                          as SharedPreferences)[
                                  currentWaypointIndex];

                              return waypoint != ''
                                  ? DetailsCard(
                                      destination: waypoint,
                                      distance: Geolocator.distanceBetween(
                                                  currentLoc.latitude,
                                                  currentLoc.longitude,
                                                  WaypointUtils
                                                      .getWaypointLatitude(
                                                          waypoint),
                                                  WaypointUtils
                                                      .getWaypointLongitude(
                                                          waypoint))
                                              .toString() +
                                          ' m')
                                  : Container();
                            },
                            itemCount: waypointCount,
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.white,
                            child: CircularProgressIndicator(
                              color: ColorUtils.deepGreen,
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: CircularProgressIndicator(
                        color: ColorUtils.deepGreen,
                      ),
                    ),
                  );
                }
              },
              future: Geolocator.getCurrentPosition(),
              ),
            ],
          ),
        ),
        onRefresh: () async {
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AddWaypointDialog(
                    context: context,
                    addWaypointController: addWaypointController);
              });
          setState(() {});
        },
        tooltip: 'Add quote',
        child: const Icon(Icons.add),
        backgroundColor: ColorUtils.deepGreen,
        elevation: 0,
      ),
    );
  }
}

// refer to this https://pub.dev/packages/flutter_compass/example
