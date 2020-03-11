import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_library/image.dart';
import 'package:image_picker/image_picker.dart';

class ColorPage extends StatefulWidget {

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  File foto;
  Color col = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () => _image()),
          IconButton(icon: Icon(Icons.edit), onPressed: (){Navigator.pushNamed(context, 'image');})
        ],
        title: Text('Image',),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: image(),
                ),
                SizedBox(height: 10.0,),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _image() async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    Color c = imageColor(foto);
    col = Color.fromRGBO(c.red, c.green, c.blue, 1.0);
    print(col);
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

  Widget _crearBoton() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0)
          ),
          onPressed: (){},
          color: col,
        );
      },
    );
  }


}