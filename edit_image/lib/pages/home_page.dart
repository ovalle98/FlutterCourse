import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:bitmap/transformations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageValueNotifier imageValueNotifier = ImageValueNotifier();

  @override
  void initState() {
    super.initState();
    imageValueNotifier.loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Image'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.brightness_4, color: Colors.white,), 
            onPressed: () => Navigator.pushNamed(context, 'bit'),
          )
        ],
      ),
      body: GestureDetector(
        onTap: (){
          imageValueNotifier.reset();
        },
        child: Center(
          child: ValueListenableBuilder<Bitmap>(
            valueListenable: imageValueNotifier ?? ImageValueNotifier(), 
            builder: (BuildContext context, Bitmap bitmap, Widget child){
              if(bitmap == null) return const CircularProgressIndicator();
              return Column(
                children: <Widget>[
                  SafeArea(
                    child: Image.memory(bitmap.buildHeaded())
                  ),
                ],
              );
            }
          ),
        )
      ),
      floatingActionButton: Buttons(
        contrastImage: contrastImage,
        brightnessImage: brightnessImage,
        saturationImage: saturationImage,
        exposureImage: exposureImage,
      ),
    );
  }

  void contrastImage() {
    if (imageValueNotifier.value != null)
      imageValueNotifier.contrastImage();
  }

  void brightnessImage() {
    if (imageValueNotifier.value != null)
      imageValueNotifier.brightnessImage();
  }

  void saturationImage() {
    if (imageValueNotifier.value != null)
      imageValueNotifier.saturationImage();
  }

  void exposureImage() {
    if (imageValueNotifier.value != null)
      imageValueNotifier.exposureImage();
  }
}

class Buttons extends StatelessWidget{
  const Buttons({
    Key key,
    this.contrastImage,
    this.brightnessImage,
    this.saturationImage,
    this.exposureImage,
  }) : super(key: key);

  final VoidCallback contrastImage;
  final VoidCallback brightnessImage;
  final VoidCallback saturationImage;
  final VoidCallback exposureImage;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: contrastImage,
                child: const Text(
                  'Contras',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 10.0),
              FlatButton(
                onPressed: brightnessImage,
                child: const Text(
                  'Brightness',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: saturationImage,
                child: const Text(
                  'Saturation',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 10.0,),
              FlatButton(
                onPressed: saturationImage,
                child: const Text(
                  'Exposure',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageValueNotifier extends ValueNotifier<Bitmap> {
  ImageValueNotifier() : super(null);
  Bitmap initial;

  void reset() {
    value = initial;
  }

  void loadImage() async {
    const ImageProvider imageProvider = const AssetImage("assets/Lobo.jpg");
    value = await Bitmap.fromProvider(imageProvider);
    initial = value;
  }

  void contrastImage() async {
    final temp = value;
    value = null;
    final Uint8List converted = await compute(
      contrastImageIsolate,
      [temp.content, temp.width, temp.height],
    );
    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
  }

  void brightnessImage() async {
    final temp = value;
    value = null;
    final Uint8List converted = await compute(
      brightnessImageIsolate,
      [temp.content, temp.width, temp.height],
    );
    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
  }

  void saturationImage() async {
    final temp = value;
    value = null;
    final Uint8List converted = await compute(
      saturationImageIsolate,
      [temp.content, temp.width, temp.height],
    );
    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
  }

  void exposureImage() async {
    final temp = value;
    value = null;
    final Uint8List converted = await compute(
      exposureImageIsolate,
      [temp.content, temp.width, temp.height],
    );
    value = Bitmap.fromHeadless(temp.width, temp.height, converted);
  }
}

Future<Uint8List> contrastImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];
  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);
  final returnBitmap = contrast(bigBitmap, 1.1);
  return returnBitmap.content;
}

Future<Uint8List> brightnessImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];
  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);
  final Bitmap returnBitmap = brightness(bigBitmap, 0.1);
  return returnBitmap.content;
}

Future<Uint8List> saturationImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];
  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);
  final Bitmap returnBitmap = adjustColor(
    bigBitmap,
    saturation: 1.0,
  );
  return returnBitmap.content;
}

Future<Uint8List> exposureImageIsolate(List imageData) async {
  final Uint8List byteData = imageData[0];
  final int width = imageData[1];
  final int height = imageData[2];
  final Bitmap bigBitmap = Bitmap.fromHeadless(width, height, byteData);
  final Bitmap returnBitmap = adjustColor(
    bigBitmap,
    exposure: 1.0,
  );
  return returnBitmap.content;
}
