import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_library/image.dart';
import 'package:image_library/munsell.dart';
import 'package:image_picker/image_picker.dart';

class ColorPage extends StatefulWidget {

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  File foto;
  Color col = Colors.red;
  Munsell m = new Munsell();
  String notacionMunsell = 'Munsell';

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
                _crearBoton(),
                SizedBox(height: 10.0,),
                _crearBotonMunsell(),
                SizedBox(height: 20.0,),
                Text(notacionMunsell),
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

  Widget _crearBotonMunsell() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Munsell'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0)
          ),
          elevation: 5.0,
          onPressed: (){
            String rgb = _colorToString();
            notacionMunsell = m.getColorMunsell(rgb);
            setState(() {});
            print(notacionMunsell);
          },
        );
      },
    );
  }

  //Convierte el RGB en String; ejemplo '000031045'
  String _colorToString(){
    String r = _completarString(col.red.toString());
    String g = _completarString(col.green.toString());
    String b = _completarString(col.blue.toString());
    return '$r$g$b';
  }

  //Completa el string a tres caracateresticas '1' => '001'
  String _completarString(String x) {
    if(x.length == 3) return x;
    else if(x.length == 2) return '0$x';
    else return '00$x';
  }

}