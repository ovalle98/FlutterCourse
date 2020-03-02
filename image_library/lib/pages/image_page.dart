import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
 
int intContrast = 10; // At 0, the image is unmodified
int intBrightness = 10; // 1.0 is the original image
int intSaturation = 10; // 1.0 is the original image
int intExposure = 0; // At 0, the image is unmodified
int cont = 1;
bool cargar = true;

class ImagePage extends StatefulWidget {

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  File foto, res;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () => _image())
        ],
        title: Text('Image',),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => reset(),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: //(!cargar) 
/*            ? Center(
              child: CircularProgressIndicator(),
              heightFactor: 10.0,)
            :*/ Column(
              children: <Widget>[
                Center(
                  child: image(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Buttons(
        contrastImage1: contrastImage1,
        contrastImage2: contrastImage2,
        brightnessImage1: brigthnessImage1,
        brightnessImage2: brigthnessImage2,
        saturationImage1: saturationImage1,
        saturationImage2: saturationImage2,
        exposureImage1: exposureImage1,
        exposureImage2: exposureImage2,
      ),
    );
  }

  void reset() {
    res = null;
    intContrast = 10;
    intBrightness = 10;
    intSaturation = 10;
    intExposure = 0;
    setState(() {});
  }

  _image() async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    setState(() {});
  }

  Widget image(){
    if(res != null) {
      return Image.file(
        res,
        fit: BoxFit.cover,
        height: 300.0,
      );
    }
    if(foto != null) {
      return Image.file(
        foto,
        fit: BoxFit.cover,
        height: 300.0,
      );
    }
    return Image.asset('assets/no-image.png', fit: BoxFit.cover, height: 300,);
  }

  contrastImage1(){
    if(intContrast > 0){
      intContrast -= 1;
      cargar = false;
      print('AAAAAAAAAAAAAAAA $cargar');
      setState((){});
      adJustImage();
    }
  }

  contrastImage2(){
    if(intContrast < 100){
      intContrast += 1;
      cargar = false;
      print('AAAAAAAAAAAAAAAA $cargar');
      setState((){});
      adJustImage();
    }
  }

  brigthnessImage1(){
    if(intBrightness > 0){
      intBrightness -= 1;
      cargar = false;
      setState((){});
      adJustImage();
    }
  }

  brigthnessImage2(){
    if(intBrightness < 100){
      intBrightness += 1;
      cargar = false;
      setState((){});
      adJustImage();
    }
  }
  
  saturationImage1(){
    if(intSaturation > 0){
      intSaturation -=  1;
      cargar = false;
      setState((){});
      adJustImage();
    }
  }

  saturationImage2(){
    if(intSaturation < 100){
      intSaturation +=  1;
      cargar = false;
      setState((){});
      adJustImage();
    }
  }

  exposureImage1(){
    if(intExposure > 0){
      intExposure -=  1;
      cargar = false;
      setState((){});
      adJustImage();
    }
  }

  exposureImage2(){
    if(intExposure < 100){
      intExposure +=  1;
      cargar = false;
      setState((){});
      adJustImage();
    }
  }

  adJustImage() async{
    if(foto != null){
      img.Image image = img.decodeImage(foto.readAsBytesSync());
      img.Image result = img.adjustColor(
        image,
        contrast: (intContrast/10),
        brightness: (intBrightness/10),
        saturation: (intSaturation/10),
        exposure: (intExposure/10)
      );
      final tempDir = await getTemporaryDirectory();
      res = File('${tempDir.path}/result$cont.jpg}')..writeAsBytesSync(img.encodePng(result));
      cont += 1;
      cargar = true;
      print('BBBBBBBBBBBBBBB $cargar');
      setState(() {});
    }
  }

  contrastImage() async{
    if(foto != null){
      img.Image image = img.decodeImage(foto.readAsBytesSync());
      img.Image result = img.contrast(image, intContrast);
      final tempDir = await getTemporaryDirectory();
      res = new File('${tempDir.path}/result$cont.jpg}')..writeAsBytesSync(img.encodePng(result));
      cont += 1;
      setState(() {});
    }
  }

}

class Buttons extends StatelessWidget{
  const Buttons({
    Key key,
    this.contrastImage1,
    this.contrastImage2,
    this.brightnessImage1,
    this.brightnessImage2,
    this.saturationImage1,
    this.saturationImage2,
    this.exposureImage1,
    this.exposureImage2,
  }) : super(key: key);

  final VoidCallback contrastImage1;
  final VoidCallback contrastImage2;
  final VoidCallback brightnessImage1;
  final VoidCallback brightnessImage2;
  final VoidCallback saturationImage1;
  final VoidCallback saturationImage2;
  final VoidCallback exposureImage1;
  final VoidCallback exposureImage2;


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
              Text('Contraste', style: TextStyle(fontSize: 20.0),),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: contrastImage1,
                color: Colors.grey,
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: (contrastImage2),
                color: Colors.blue,
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 3.0),
              Text((intContrast/10).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('brillo', style: TextStyle(fontSize: 20.0),),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: brightnessImage1,
                color: Colors.grey,
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: brightnessImage2,
                color: Colors.blue,
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 3.0),
              Text((intBrightness/10).toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Saturación', style: TextStyle(fontSize: 20.0),),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: saturationImage1,
                color: Colors.grey,
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: saturationImage2,
                color: Colors.blue,
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 3.0),
              Text((intSaturation/10).toString()),
            ],
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Expanción', style: TextStyle(fontSize: 20.0),),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: exposureImage1,
                color: Colors.grey,
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 2.0),
              FlatButton(
                onPressed: exposureImage2,
                color: Colors.blue,
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 3.0),
              Text((intExposure/10).toString()),
            ],
          ),
        ],
      ),
    );
  }
}
