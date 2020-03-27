
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

void toastShow(BuildContext context, String msg, Color back, Color text){
  Toast.show(
        msg,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: back,
        textColor: text,
      );
}