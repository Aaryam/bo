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
      tag: destination,
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
                  destination.length <= 8
                      ? Text('$destination',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          ))
                      : Text(destination.substring(0, 8) + '...',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          )),
                  Text('$distance',
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
                        tag: destination,
                        title: '',
                      )),
            );
          },
        ),
      ),
    );
  }
}
