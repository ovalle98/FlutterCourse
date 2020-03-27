import 'package:flutter/material.dart';

import 'package:login_sqflite/src/color/clors.dart';
import 'package:login_sqflite/src/widgets/campo.dart';
import 'package:login_sqflite/src/widgets/toast.dart';
import 'package:login_sqflite/src/page/menu_page.dart';
import 'package:login_sqflite/src/provider/db_provider.dart';
import 'package:login_sqflite/src/models/usuario_model.dart';

class HomePage extends StatefulWidget {
  User user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  User _user;
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  
  _HomePageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getFondo(),
      body: Center(
        child: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        ),
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: getCirculo(),
      ),
    );
    return Stack(
      children: <Widget>[
        Positioned( top: 90.0, left: 10.0, child: circulo),
        Positioned( top: -10.0, right: -20.0, child: circulo),
        Positioned( bottom: -50.0, right: -10.0, child: circulo),
        Positioned( bottom: 120.0, right: 20.0, child: circulo),
        Positioned( bottom: -50.0, left: -20.0, child: circulo),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: getForm(),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow> [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Icon(Icons.person, color: getPrimary(), size: 50.0,),
                  Text('Inicio de sesión', style: TextStyle(fontSize: 20.0, color: getPrimary())),
                  SizedBox(height: 20.0,),
                  crearEmail(cEmail),
                  SizedBox(height: 25.0,),
                  crearPassword(cPassword, false),
                  SizedBox(height: 40.0,),
                  _crearBotonInicio(),
                  SizedBox(height: 10.0,),
                  _crearBotonRegistro(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _crearBotonInicio() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0)
          ),
          elevation: 5.0,
          color: getBoton(),
          textColor: getTextBoton(),
          onPressed: () => _vacio(context)
        );
      },
    );
  }

  Widget _crearBotonRegistro() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registro'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0)
          ),
          elevation: 5.0,
          color: getBoton(),
          textColor: getTextBoton(),
          onPressed: (){Navigator.pushReplacementNamed(context, 'registro');},
        );
      },
    );
  }

  _vacio(BuildContext context){
    if(cPassword.text != "" && cEmail.text != "") 
      _login(context);
    else
      toastShow(context, "Llenar todos los campos", getPrimary(), getError());
  }

  _login(BuildContext context) async{
    _user = await DBProvider.db.getUserEmailToPassword(cEmail.text, cPassword.text);
    if(_user == null){
      toastShow(context, "Datos incorrectos", getPrimary(), getError());
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => MenuPage(_user),
    ));
  }
}