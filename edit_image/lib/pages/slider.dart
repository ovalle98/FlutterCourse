import 'dart:io';
import 'dart:typed_data';

import 'package:edit_image/edit_image.dart';
import 'package:flutter/material.dart';
import 'package:bitmap/bitmap.dart';
import 'package:bitmap/transformations.dart' as bmp;
import 'package:image_picker/image_picker.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  File foto;
  File r;
  double _valorSlider = 0.5;
  Image im;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Image'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.brightness_4, color: Colors.white,), 
            onPressed: () => Navigator.pushNamed(context, 'bit'),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      _mostrarFoto(),
                      SizedBox(height: 10.0),
                      _mostrarFotoR(),
                      SizedBox(height: 10.0),
                      _crearSlider(),
                      SizedBox(height: 10.0),
                      Text(_valorSlider.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  _seleccionarFoto() async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    setState(() {});
  }

  Widget _mostrarFoto(){
    Image im;
    if(foto != null)
    {
      im = Image.file(
        foto,
      );
//      getFile(foto);
    }
    else im = Image.asset('assets/no-image.png');
    return im;
  }

  Widget _mostrarFotoR(){
    if(foto != null) _brillo(_valorSlider);
    if(im != null)
      return im;
    else return Image.asset('assets/no-image.png');
  }

  _brillo(double a) async{
    Image image = Image.file(foto);
    Bitmap bitmap = await Bitmap.fromProvider(image.image);
    Bitmap brightBitmap = bmp.brightness(bitmap, a);
    Uint8List headedBitmap = brightBitmap.buildHeaded();
    im = Image.memory(headedBitmap);
  }

  Widget _crearSlider(){
    return Slider(
      activeColor: Colors.indigoAccent,
      value: _valorSlider * 10,
      max: 10.0,
      onChanged: (valor){
          _valorSlider = valor / 10.0;
      },
      onChangeEnd: (valor){
        _brillo(_valorSlider);
        setState(() {
        });
        setState(() {
          
        });
      },
    );
  }
  


}