import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper{
  Future<Database> initDB() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');
    return await openDatabase(path, onCreate: (db, version){
      const sql = "CREATE TABLE filmes("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "url_imagem TEXT,"
          "titulo TEXT,"
          "genero TEXT,"
          "faixa_etaria TEXT,"
          "duracao INTEGER,"
          "pontuacao FLOAT,"
          "descricao TEXT,"
          "ano INTEGER);";
      db.execute(sql);
    }, version: 1);
  }
}