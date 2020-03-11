
import 'dart:io';
import 'dart:ui';

import 'package:image/image.dart' as img;

int mayor=0, red, green, blue, redP=0, greenP=0, blueP=0;
Color colorFinal, c;
Map<Color, int> map;

Color imageColor(File foto){
  img.Image im = img.decodeImage(foto.readAsBytesSync());
//  im = img.copyResize(im, width: (im.width*0.10).toInt(), height: (im.height*0.10).toInt());
  im = img.copyResize(im, width: 200, height: 200);
  
  for (var i = 0; i < im.width; i++) {
    for (var j = 0; j < im.height; j++) {
      c = Color(im.getPixel(i, j));
      red = c.red;
      green = c.green;
      blue = c.blue;
      redP += red;
      greenP += green;
      blueP += blue;
    }
  }
  redP = (redP/(im.width*im.height)).round();
  greenP = (greenP/(im.width*im.height)).round();
  blueP = (blueP/(im.width*im.height)).round();
  c = Color.fromRGBO(blueP, greenP, redP, 1.0);
  colorFinal = c;
  print('-------------------------------------------------');
  print('$c RGB($redP, $greenP, $blueP)');
  print('$colorFinal  ${colorFinal.red} ${colorFinal.green} ${colorFinal.blue}');
  print('-------------------------------------------------');
  return colorFinal;
}