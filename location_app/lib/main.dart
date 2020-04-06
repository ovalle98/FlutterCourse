import 'package:flutter/material.dart';

import 'package:location_app/pages/get_location_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Location',
      initialRoute: 'getLocation',
      routes: {
        'getLocation' : (BuildContext c) => GetLocationPage(),
      },
    );
  }
}