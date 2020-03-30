import 'package:flutter/material.dart';

import 'package:login_sqflite/src/color/clors.dart';
import 'package:login_sqflite/src/page/home_page.dart';
import 'package:login_sqflite/src/page/menu_page.dart';
import 'package:login_sqflite/src/page/registro_page.dart';
import 'package:login_sqflite/src/models/token_model.dart';
import 'package:login_sqflite/src/provider/db_provider.dart';

String p;// = 'home';
Token t;// = Token(id: 'null');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  t = await DBProvider.db.getToken();
  print(t);
  if( t == null || t.nombre == 'null')
    p = 'home';
  else
    p = 'menu';
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: p,
      routes: {
        'home' : (BuildContext context) => HomePage(null),
        'menu' : (BuildContext context) => MenuPage(null),
        'registro' : (BuildContext context) => RegistroPage(),
      },
      theme: ThemeData(
        primaryColor: getPrimary(),
        colorScheme : ColorScheme.dark(),
        hintColor: getPrimary(),
        cursorColor: getPrimary(),
        canvasColor: getFondo(),
      ),
    );
  }
}