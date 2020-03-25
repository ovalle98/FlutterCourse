
import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/provider/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();
  
  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }
  
  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScans(ScanModel scan) async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScans(int id) async{
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }
  
  borrarTodosScans() async {
    DBProvider.db.deleteAll();
    obtenerScans();
  }




}