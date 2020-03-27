
class User {
  int id;
  String email;
  String nombre;
  String password;

  User({
    this.id,
    this.email,
    this.nombre,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    email: json["email"],
    nombre: json["nombre"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "email" : email,
    "nombre" : nombre,
    "password" : password,
  };
}