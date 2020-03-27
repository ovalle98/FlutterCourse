import 'package:flutter/material.dart';

import 'package:login_sqflite/src/bloc/tarea_bloc.dart';
import 'package:login_sqflite/src/models/tarea_models.dart';
import 'package:login_sqflite/src/models/usuario_model.dart';
import 'package:login_sqflite/src/page/tarea_page.dart';
import 'package:login_sqflite/src/provider/db_provider.dart';

class MenuPage extends StatefulWidget {
  User user;
  MenuPage(this.user);

  @override
  _MenuPageState createState() => _MenuPageState(this.user);
}

class _MenuPageState extends State<MenuPage> {
  final tareaBloc = TareaBloc();
  User _user;
  int currentIndex = 0;
  
  _MenuPageState(this._user);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => tareaBloc.borrarTodasTareas()
          )
        ],
      ),
      body: TareaPage(_user),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: adTarea,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  adTarea() async {
    Tarea tarea = new Tarea(nombre: 'Tarea de ${_user.nombre}', idUser: _user.id);
    tareaBloc.agregarTarea(tarea);
    print(_user.toJson());
    print(tarea.toJson());
  }
}