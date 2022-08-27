import 'package:bo/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:bo/main.dart';

import '../pages/navigatepage.dart';

class DetailsCard extends StatelessWidget {
  final String destination;
  final String distance;

  const DetailsCard(
      {Key? key, required this.destination, required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: WaypointUtils.getWaypointName(destination),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  WaypointUtils.getWaypointName(destination).length <= 8
                      ? Text(WaypointUtils.getWaypointName(destination),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          ))
                      : Text(WaypointUtils.getWaypointName(destination).substring(0, 8) + '...',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          )),
                  Text(distance.toString().substring(0, distance.indexOf('.') + 3) + ' m',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                      )),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigatePage(
                        tag: WaypointUtils.getWaypointName(destination),
                        title: '',
                        destination: WaypointUtils.getWaypointPosition(destination),
                      )),
            );
          },
        ),
      ),
    );
  }
}
