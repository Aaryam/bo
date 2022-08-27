import 'package:bo/pages/startpage.dart';
import 'package:bo/widgets/detailscard.dart';
import 'package:flutter/material.dart';
import 'package:bo/misc/utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            const DetailsCard(destination: 'This is cool.', distance: '01/01/22'),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          
        });
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add quote',
        child: const Icon(Icons.add),
        backgroundColor: ColorUtils.deepGreen,
        elevation: 0,
      ),
    );
  }
}

// refer to this https://pub.dev/packages/flutter_compass/example
