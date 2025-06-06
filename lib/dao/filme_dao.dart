import 'package:app_filmes/database/database_helper.dart';
import 'package:app_filmes/model/filme.dart';

class FilmeDao {
  late DatabaseHelper dbHelper;

  FilmeDao() {
    dbHelper = DatabaseHelper();
  }

  Future<int?> save(Filme filme) async {
    final db = await dbHelper.initDB();
    try{
      return await db.insert('filmes', filme.toMap());
    }catch(e){
      print(e);
      return null;
    }finally{
      db.close();
    }
  }

  Future<int?> alter(Filme filme) async{
    final db = await dbHelper.initDB();
    try{
      return await db.update(
          'filmes',
          filme.toMap(),
          where: 'id = ?',
          whereArgs: [filme.id]
      );
    }catch(e){
      print(e);
      return null;
    }finally{
      db.close();
    }
  }

  Future<int?> remove(Filme filme) async{
    final db = await dbHelper.initDB();
    try{
      return await db.delete(
          'filmes',
          where: 'id = ?',
          whereArgs: [filme.id]
      );
    }catch(e){

    }
  }

  Future<List<Filme>?> findAll() async{
    final db = await dbHelper.initDB();
    try{
      final listMap = await db.query('filmes');
      List<Filme> filmes = [];
      for(var map in listMap){
        filmes.add(Filme.fromMap(map));
      }
      return filmes;
    }catch(e){
      return null;
    }finally{
      db.close();
    }
  }
}