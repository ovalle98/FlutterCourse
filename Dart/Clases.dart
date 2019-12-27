void main(){
  final wolverin = new Heroe(nombre: 'Logan', poder : 'Regeneración');
  print(wolverin);
   print(wolverin.nombre);
   print(wolverin.poder);

}

class Heroe{
  String nombre;
  String poder;

  Heroe({String nombre = 'Sin nombre', String poder}){
    this.nombre = nombre;
    this.poder = poder;
  }

  Heroe({this.nombre, this.poder});

  String toString() => 'Nombre : $nombre - Poder : $poder';
}
