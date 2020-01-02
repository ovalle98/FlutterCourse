import 'package:flutter/material.dart';

import 'package:componentes/src/page/alert_page.dart';
import 'package:componentes/src/page/avatar_page.dart';
import 'package:componentes/src/page/home_pages.dart';
import 'package:componentes/src/page/card_pages.dart';
import 'package:componentes/src/page/animated_contanier.dart';
import 'package:componentes/src/page/input_page.dart';
import 'package:componentes/src/page/slider_page.dart';
import 'package:componentes/src/page/listview_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'alert' : (BuildContext context) => AlertPage(),
    'avatar' : (BuildContext context) => AvatarPage(),
    'card' : (BuildContext context) => CardPage(),
    'animatedContainer' : (BuildContext context) => AnimatedContinerPage(),
    'inputs' : (BuildContext context) => InputPage(),
    'slider' : (BuildContext context) => SliderPage(),
    'list' : (BuildContext context) => ListaPage(),
  };
} 