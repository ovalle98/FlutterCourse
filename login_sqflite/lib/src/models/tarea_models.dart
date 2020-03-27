
class Tarea {
  int id;
  String nombre;
  int idUser;

  Tarea({
    this.id,
    this.nombre,
    this.idUser
  });

  factory Tarea.fromJson(Map<String, dynamic> json) => new Tarea(
    id: json["id"],
    nombre: json["nombre"],
    idUser: json["idUser"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "nombre" : nombre,
    "idUser" :idUser,
  };
}