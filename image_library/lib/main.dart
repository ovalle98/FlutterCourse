import 'package:flutter/material.dart';
import 'package:image_library/pages/image_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrieal App',
      initialRoute: 'image',
      routes: {
        'image' : (BuildContext context) => ImagePage(),
      },
    );
  }
}