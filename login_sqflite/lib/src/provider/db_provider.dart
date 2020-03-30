import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:login_sqflite/src/models/token_model.dart';
import 'package:login_sqflite/src/models/tarea_models.dart';
import 'package:login_sqflite/src/models/usuario_model.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._(); //Constructor Privado
  
  DBProvider._();

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String directory = await getDatabasesPath();
    final path = join(directory, 'Ejemplo.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE user ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'email TEXT NOT NULL,'
          'nombre TEXT NOT NULL,'
          'password TEXT NOT NULL'
          ')'
        );

        await db.execute(
          'CREATE TABLE tarea ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'nombre TEXT NOT NULL,'
          'id_user,'
          'CONSTRAINT fk_tarea_user'
          ' FOREIGN KEY (id_user)'
          ' REFERENCES user(id)'
          ')'
        );

        await db.execute(
          'CREATE TABLE token ('
          'id INTEGER PRIMARY KEY,'
          'nombre TEXT NOT NULL'
          ')'
        );
      },
    );
  }

  //CREAR REGISTRO
  Future<int> addUser(User user) async{
    final db = await  database;
    final res = await db.rawInsert(
      "INSERT Into user (email, nombre, password) "
      "VALUES ('${user.email}', '${user.nombre}', '${user.password}' )"
    );
    return res;
  }

  Future<int> addTarea(Tarea tarea) async{
    final db = await  database;
    final res = await db.rawInsert(
      "INSERT Into tarea (nombre, id_user) "
      "VALUES ('${tarea.nombre}', ${tarea.idUser} )"
    );
    return res;
  }

  Future<int> insertUser(User user) async{
    final db = await database;
    final res = await db.insert('user', user.toJson());
    return res;
  }

  Future<int> insertToken(Token t) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT Into token (id, nombre) "
      "VALUES (${t.id}, '${t.nombre}')"
    );
    return res;
  }

    //Obtener información
  Future<User> getUserId(int id) async {
    final db  = await database;
    final res = await db.query('user', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? User.fromJson(res.first) : null;
  }

  Future<User> getUserEmail(String email) async {
    final db  = await database;
    final res = await db.query('user', where: 'email = ?', whereArgs: [email]);
    return res.isNotEmpty ? User.fromJson(res.first) : null;
  }

  Future<User> getUserEmailToPassword(String e, String p) async {
    final db  = await database;
    final res = await db.query('user', where: 'email = ? and password = ?', whereArgs: [e, p]);
    return res.isNotEmpty ? User.fromJson(res.first) : null;
  }

  Future<Token> getToken() async{
    final db = await database;
    final res = await db.query('token');
    return res.isNotEmpty ? Token.fromJson(res.first) : null;
  }

  Future<List<User>> getUsers() async{
    final db = await database;
    final res = await db.query('user');
    List<User> list = res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Tarea>> getTareas() async{
    final db = await database;
    final res = await db.query('tarea');
    List<Tarea> list = res.isNotEmpty ? res.map((c) => Tarea.fromJson(c)).toList() : [];
    return list;
  }
  
  //Actualizar registro
  Future<int> updateUser(User user) async {
    final db = await database;
    final res = await db.update('user', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
    return res;
  }

  Future<int> updateToken(Token t) async {
    final db = await database;
    final res = await db.update('token', t.toJson(), where: 'id = ?', whereArgs: [t.id]);
    return res;
  }

  //Eliminar Registro
  Future<int> deleteUser(int id)  async {
    final db = await database;
    final res = await db.delete('user', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteTarea(int id)  async {
    final db = await database;
    final res = await db.delete('tarea', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll()  async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM user');
    return res;
  }

  Future<int> deleteAllT()  async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM tarea');
    return res;
  }

}