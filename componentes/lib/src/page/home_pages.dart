import 'package:flutter/material.dart';

import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icon_string_util.dart';
import 'package:componentes/src/page/alert_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),  
      body: _lista(),
    );
  }

  Widget _lista() {
//    menuProvider.cargarData().then((opciones){
//      print('_lista');
//      print(opciones);
//    });

    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );

//    return ListView(
//      children: _listaItems(),
//    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt){
      final  widgetTmp  = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: (){
//          final route = MaterialPageRoute(
//            builder: (context) => AlertPage()
//          );
//          Navigator.push(context, route);
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      opciones..add(widgetTmp)
              ..add(Divider());
    });

    return opciones;
  }
}