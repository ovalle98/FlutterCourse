import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File foto;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Image'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera), 
            onPressed: () => getImage(ImageSource.camera),
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
                      _image(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    File image = await ImagePicker.pickImage(source: imageSource);
    Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    File newImage = await image.copy('$path/image.jpg');
    setState(() {
      foto = newImage;
    });
  }

  Widget _image(){
      if(foto != null)
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );

      return Image.asset('assets/no-image.png');
  }

}