void main(){
  String propiedad = 'soltero';
  Map<String, dynamic> persona = {
    'nombre' : 'Juan',
    'edad' : 32,
    'soltero' : true
  };

  print(persona['nombre']);
  print(persona[propiedad]);

  Map<int, String> per = {
    1 : 'Tony',
    2 : 'Peter',
    9 : 'Strange'
  };

  per.addAll({4 : 'Banner'});
  print(per);
  print(per[2]);
}
