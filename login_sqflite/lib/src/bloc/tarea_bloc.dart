
import 'dart:async';

import 'package:login_sqflite/src/models/tarea_models.dart';
import 'package:login_sqflite/src/provider/db_provider.dart';


class TareaBloc {
  static final TareaBloc _singleton = new TareaBloc._internal();
  
  factory TareaBloc(){
    return _singleton;
  }

  TareaBloc._internal(){
    obtenerTareas();
  }

  final _tareaController = StreamController<List<Tarea>>.broadcast();

  Stream<List<Tarea>> get tareaStream => _tareaController.stream;

  dispose(){
    _tareaController?.close();
  }
  
  obtenerTareas() async {
    _tareaController.sink.add(await DBProvider.db.getTareas());
  }

  agregarTarea(Tarea tarea) async{
    await DBProvider.db.addTarea(tarea);
    obtenerTareas();
  }

  borrarTarea(int id) async{
    await DBProvider.db.deleteTarea(id);
    obtenerTareas();
  }
  
  borrarTodasTareas() async {
    DBProvider.db.deleteAllT();
    obtenerTareas();
  }




}