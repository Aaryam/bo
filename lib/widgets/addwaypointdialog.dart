import 'package:bo/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWaypointDialog extends StatelessWidget {

  final BuildContext context;
  final TextEditingController addWaypointController;

  const AddWaypointDialog({Key? key, required this.addWaypointController, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Waypoint"),
      content: Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width,
                child: TextField(  
              controller: addWaypointController,
              decoration: const InputDecoration(hintText: "Add Waypoint"),  
            ),  
              ),
      actions: [
        TextButton(
          child: const Text("Add", style: TextStyle(
            color: ColorUtils.deepGreen,
          ),),
          onPressed: () async {

            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            String waypoints = sharedPreferences.getString('waypoints') ?? '';

            if (addWaypointController.text.contains(',') || addWaypointController.text.contains(';') || waypoints.contains(addWaypointController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You cannot use duplicate waypoint names or the characters ':' or ','.")));
              addWaypointController.clear();
            }
            else {
              WaypointUtils.addWaypoint(addWaypointController.text, await Geolocator.getCurrentPosition(), await SharedPreferences.getInstance());
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
