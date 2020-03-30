class Token {
  int id;
  String nombre;

  Token({this.id, this.nombre});

  factory Token.fromJson(Map<String, dynamic> json) => new Token(
    id: json["id"],
    nombre: json["nombre"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "nombre" : nombre
  };
}