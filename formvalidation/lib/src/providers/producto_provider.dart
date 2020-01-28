
import 'dart:convert';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductoProvider{
  final String _url = 'https://flutter-7dec6.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async{
    final url = '$_url/productos.json';
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async{
    final url = '$_url/productos/${producto.id}.json';
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async{
    final url = '$_url/productos.json';
    final reps = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(reps.body);
    final List<ProductoModel> productos = new List();
    if(decodeData == null) return [];
    decodeData.forEach((id,prod){
      final prodTemo = ProductoModel.fromJson(prod);
      prodTemo.id = id;
      productos.add(prodTemo);
    });
    return productos;
  }

  Future<int> borrarProducto(String id) async{
    final url = '$_url/productos/$id.json';
    final res = await http.delete(url);
    return 1;
  } 
}