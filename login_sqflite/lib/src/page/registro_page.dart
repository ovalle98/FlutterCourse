import 'package:flutter/material.dart';

import 'package:login_sqflite/src/color/clors.dart';
import 'package:login_sqflite/src/widgets/campo.dart';
import 'package:login_sqflite/src/widgets/toast.dart';
import 'package:login_sqflite/src/page/home_page.dart';
import 'package:login_sqflite/src/models/usuario_model.dart';
import 'package:login_sqflite/src/provider/db_provider.dart';

class RegistroPage extends StatefulWidget {

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController cPassword = TextEditingController();
  TextEditingController cNombre  = TextEditingController();
  TextEditingController cEmail = TextEditingController();


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
        color: getCirculo()
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned( top: 90.0, left: 10.0, child: circulo),
        Positioned( top: -10.0, right: -20.0, child: circulo),
        Positioned( bottom: -50.0, right: -10.0, child: circulo),
        Positioned( bottom: 120.0, right: 20.0, child: circulo),
        Positioned( bottom: -50.0, left: -20.0, child: circulo),

        Container(
          //padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              //Icon(Icons.person_add, color: getPrimary(), size: 70.0,),
              //SizedBox(height: 10.0, width: double.infinity,),
            ],
          )
        )
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
                    spreadRadius: 5.0,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Icon(Icons.person_add, color: getPrimary(), size: 50.0,),
                  Text('Registro', style: TextStyle(fontSize: 20.0, color: getPrimary())),
                  SizedBox(height: 25.0,),
                  crearNombre(cNombre, 'Nombre'),
                  SizedBox(height: 15.0,),
                  crearEmail(cEmail),
                  SizedBox(height: 15.0,),
                  crearPassword(cPassword, true),
                  SizedBox(height: 30.0,),
                  _crearBoton(),
                  SizedBox(height: 15.0,),
                  _crearBotonInicio()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0)
          ),
          elevation: 5.0,
          color: getBoton(),
          textColor: getTextBoton(),
          onPressed: () => _vacio(context),
        );
      },
    );
  }

  Widget _crearBotonInicio() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Login'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0)
          ),
          elevation: 5.0,
          color: getBoton(),
          textColor: getTextBoton(),
          onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
        );
      },
    );
  }

  _vacio(BuildContext context){
    if(cNombre.text.isNotEmpty && cEmail.text.isNotEmpty && cPassword.text.isNotEmpty)
      _registro(context);
    else 
      toastShow(context, 'Llenar todos los campos', getPrimary(), getError());
  }

  _registro(BuildContext context) async{
    User r = await DBProvider.db.getUserEmail(cEmail.text);
    if(r == null){//No existe el correo
      final user = User(email: cEmail.text, nombre: cNombre.text, password: cPassword.text);
      await DBProvider.db.addUser(user);
      //await DBProvider.db.insertUser(user);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomePage(user),
      ));
    }
    else toastShow(context, 'El correo ya esta en uso', getPrimary(), getError());
  }

}