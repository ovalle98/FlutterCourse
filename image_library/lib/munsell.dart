
import 'package:image_library/utils/colorRYMunsell.dart';
import 'package:image_library/utils/notacionRYMunsell.dart';
//import 'package:image_library/utils/notacionMunsell.dart';
//import 'package:image_library/utils/rgbMunsell.dart';

class Munsell {
  
  String getColorMunsell(String rgb){
    int RGB = int.parse(rgb);
   /* if(colorRGB.contains(rgb)) {
      int indice = colorRGB.indexOf(rgb);
      return notacionMunsell[indice];
    }
    else{
      if(RGB <= int.parse(colorRGB[0])) return notacionMunsell[0];
      for (var i=1; i<2251; i++) {
        if(RGB == int.parse(colorRGB[i])) return notacionMunsell[i];
        else if(RGB < int.parse(colorRGB[i])){
          int n1 = RGB - int.parse(colorRGB[i-1]);
          int n2 = int.parse(colorRGB[i])  - RGB;
          if(n1 > n2) return notacionMunsell[i];
          else return notacionMunsell[i-1];
        }
      }
    }*/
    if(colorM.contains(rgb)) {
      int indice = colorM.indexOf(RGB);
      return notM[indice];
    }
    else{
      if(RGB <= colorM[0]) return notM[0];
      for (var i=1; i<colorM.length; i++) {
        if(RGB == colorM[i]) return notM[i];
        else if(RGB < colorM[i]){
          int n1 = RGB - colorM[i-1];
          int n2 = colorM[i]  - RGB;
          if(n1 > n2) return '${notM[i]}';
          else return notM[i-1];
        }
      }
      return notM[colorM.length-1];
    }
  }
}