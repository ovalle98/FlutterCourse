import 'package:flutter/material.dart';

import 'package:image_color/color.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrieal App',
      initialRoute: 'color',
      routes: {
        'color' : (BuildContext context) => ColorPickerWidget(),
      },
    );
  }
}