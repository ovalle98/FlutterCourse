import 'package:flutter/material.dart';
import 'package:login_sqflite/src/bloc/tarea_bloc.dart';
import 'package:login_sqflite/src/models/tarea_models.dart';
import 'package:login_sqflite/src/models/usuario_model.dart';

class TareaPage extends StatefulWidget {
  User user;
  TareaPage(this.user);

  @override
  _TareaPageState createState() => _TareaPageState(this.user);
}

class _TareaPageState extends State<TareaPage> {
  final tareaBloc = TareaBloc();
  User _user;
  _TareaPageState(this._user);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tarea>>(
      stream: tareaBloc.tareaStream,
      builder: (BuildContext context, AsyncSnapshot<List<Tarea>> snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final tareas = snapshot.data;
        /*if(tareas.length == 0){
          return Center(child: Text('No hay información'),);

        }*/
        return ListView.builder(
          itemCount: tareas.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red,),
            onDismissed: (direccion) => tareaBloc.borrarTarea(tareas[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color:Theme.of(context).primaryColor),
              title: Text(tareas[i].nombre),
              subtitle: Text('ID : ${tareas[i].id}   IDUser : ${tareas[i].idUser}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            )
          )
          
          
        );
      }
    );
    /*return Scaffold(
      backgroundColor: getPrincipal(),
      appBar: AppBar(
        title: Text('Menú', style: TextStyle(color: getPrimary()),),
        backgroundColor: getFondo(),
        iconTheme: new IconThemeData(color: getPrimary()),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: null)
        ],
      ),
      drawer: MenuWidgets(),
    );*/
  }
}