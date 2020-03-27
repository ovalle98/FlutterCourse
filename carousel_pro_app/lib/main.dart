import 'package:flutter/material.dart';

import 'package:carousel_pro/carousel_pro.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageCarosuel(),
    );
  }
}

class ImageCarosuel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Imagen'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Carousel(
              boxFit: BoxFit.cover,
              images: [
                AssetImage('asset/L1.jpg'),
                AssetImage('asset/L2.jpg'),
                AssetImage('asset/L3.jpg'),
                AssetImage('asset/L4.jpg'),
                AssetImage('asset/L5.jpg'),
                AssetImage('asset/L6.jpg'),
                AssetImage('asset/L7.jpg'),
                AssetImage('asset/L8.jpg'),
              ],
              animationCurve: Curves.linear,
              animationDuration: Duration(seconds: 2),
              autoplay: false
            ),
          ),
        ),
      ),
    );
  }
}