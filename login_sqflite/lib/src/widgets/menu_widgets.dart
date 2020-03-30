import 'dart:io';
import 'package:flutter/material.dart';

import 'package:login_sqflite/src/color/clors.dart';
import 'package:login_sqflite/src/models/token_model.dart';
import 'package:login_sqflite/src/provider/db_provider.dart';

class MenuWidgets extends StatelessWidget {
  File foto;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: getTransparente(),
                child: ClipOval(
                  child: 
                    Icon(Icons.account_circle, size: 130.0, color: getCirclePerson()),
                ), 
              ),
            ),
            decoration: BoxDecoration(
              color: getPrincipal(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu, color: getPrimary(), size: 30.0),
            title: Text('Menú', style: TextStyle(color: getPrimary(), fontSize: 20.0)),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.person , color: getPrimary(), size: 30.0),
            title: Text('Cerrar sesión', style: TextStyle(color: getPrimary(), fontSize: 20.0)),
            onTap: () => cerrarSesion(context)
          ),
        ],
      ),
    );
  }

  void cerrarSesion(BuildContext context)async{
    //print('Home ${await _returnValue()}');
    DBProvider.db.updateToken(Token(id: 1, nombre: 'null'));
    Navigator.pushReplacementNamed(context, 'home');
  }

}