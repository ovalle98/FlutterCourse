import 'dart:io';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

File _file;


image(File f) async{
  // Read a jpeg image from file.
  Image image = decodeJpg(f.readAsBytesSync());
  print(image.getBytes() );
/*
  Image im = image.fill(Color.fromRgb(80,40,100));
  print(image.getBytes(format: Format.rgb) );
  Directory directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;
  print('jandjnsjdnajsndjnd $path');
  _file = File('$path/image.png')..writeAsBytesSync(encodePng(im)); 
  //File('foto-test.png').writeAsBytesSync(encodePng(image));
*/
}

File getFile(File f) {
  image(f);
  return _file;
}