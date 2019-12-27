void main(){
  String msj = saludar(nombre: 'Juan',texto :'Hola');
  String msj2 = saludar2(nombre: 'Antonio',texto :'Hola');

  print(msj);
  print(msj2);
}

String saludar({String texto, String nombre}){
//   print('Hola');
  return '$texto $nombre';
}

String saludar2({String texto, String nombre}) => '$texto $nombre';
