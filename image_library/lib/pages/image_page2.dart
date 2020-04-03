import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
 
int contrast = 10; // At 0, the image is unmodified
int cont = 1;
bool cargar = false;

class ImagePage2 extends StatefulWidget {

  @override
  _ImagePageState2 createState() => _ImagePageState2();
}

class _ImagePageState2 extends State<ImagePage2> {
  File foto, res, original;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () => _image()),
          IconButton(icon: Icon(Icons.color_lens), onPressed: (){Navigator.pushNamed(context, 'color');})
        ],
        title: Text('Image',),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => reset(),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    image(),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Contraste', style: TextStyle(fontSize: 20.0),),
                        SizedBox(width: 2.0),
                        FlatButton(
                          onPressed: () => contrastImage(true),
                          color: Colors.grey,
                          child: const Text('-', style: TextStyle(fontSize: 20)),
                        ),
                        SizedBox(width: 2.0),
                        FlatButton(
                          onPressed: () => contrastImage(false),
                          color: Colors.blue,
                          child: const Text('+', style: TextStyle(fontSize: 20)),
                        ),
                        SizedBox(width: 3.0),
                        Text((contrast/10).toString()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void reset() {
    res = null;
    foto = original;
    contrast = 10;
    setState(() {});
  }

  _image() async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    res = foto;
    original = foto;
    setState(() {});
  }

  Widget image(){
    if(foto != null) {
      return Image.file(
        foto,
        fit: BoxFit.cover,
        height: 300.0,
      );
    }
    return Image.asset('assets/no-image.png', fit: BoxFit.cover, height: 300,);
  }

  void contrastImage(bool resta){
    cargar = true;
    setState(() {});
    //Disminuye el contraste
    if(resta) {
      if(contrast > 0){
        contrast -= 1;
        adJustImage();
      }
    }
    //Aumenta el constraste
    else{
      contrast += 1;
      adJustImage();
    }
  }

  adJustImage() async{
    if(original != null){
      img.Image image = img.decodeImage(original.readAsBytesSync());
      img.Image result = img.adjustColor(image, contrast: (contrast/10));
      final tempDir = await getTemporaryDirectory();
      res = File('${tempDir.path}/result$cont.jpg}')..writeAsBytesSync(img.encodePng(result));
      foto = res;
      cont += 1;
      Toast.show(
        'Se a modificado la imagen',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
      setState(() {});
    }
  }
}