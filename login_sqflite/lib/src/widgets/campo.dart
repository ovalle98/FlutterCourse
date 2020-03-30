import 'package:flutter/material.dart';

import 'package:login_sqflite/src/color/clors.dart';

Widget crearEmail(TextEditingController controller) {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: getPrimary()),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.0),
            ),
            icon: Icon(Icons.alternate_email, color:getPrimary(),),
            hintText: 'ejemplo@correo.com',
            labelText: 'Email',
          ),
        ),
      );
    },
  );
}
  
Widget crearPassword(TextEditingController controller, bool registro) {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: controller,
          obscureText: true,
          style: TextStyle(color: getPrimary()),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.0),
            ),
            icon: Icon(Icons.lock_outline, color: getPrimary()),
            labelText: 'Contraseña',
            helperText: registro ? 'Usa 5 o más caracteres' : null
          ),
        ),
      );
    },
  );
}

Widget crearNombre(TextEditingController controller, String labelText) {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(color: getPrimary()),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.0),
            ),
            labelText: labelText,//'Apellido Paterno',
            icon: Icon(Icons.account_circle, color: getPrimary(),),
          ),
        ),
      );
    },
  );
}
