import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/producto_provider.dart';

class HomePage extends StatelessWidget {
  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _cearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _cearListado(){
    return FutureBuilder(
      future: productoProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final prod = snapshot.data;
          return ListView.builder(
            itemCount: prod.length,
            itemBuilder: (context, i) => _crearItem(context,prod[i]),
          );
        }
        else return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _crearItem(BuildContext context,ProductoModel prod){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red,),
      onDismissed: (direccion){
        productoProvider.borrarProducto(prod.id);
      },
      child: ListTile(
        title: Text('${prod.titulo} - ${prod.valor}'),
        subtitle: Text(prod.id),
        onTap: () => Navigator.pushNamed(context, 'producto', arguments: prod),
      ),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}