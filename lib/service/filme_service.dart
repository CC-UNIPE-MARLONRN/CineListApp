import 'package:app_filmes/model/filme.dart';
import 'package:app_filmes/dao/filme_dao.dart';

class FilmeService{
  final _filmeDao = FilmeDao();

  Future<List<Filme>?> findAll() async{
    return await _filmeDao.findAll();
  }

  Future<int?> save(Filme filme) async{
    return await _filmeDao.save(filme);
  }

  Future<int?> alter(Filme filme) async{
    return await _filmeDao.alter(filme);
  }

  Future<int?> remove(Filme filme) async{
    return await _filmeDao.remove(filme);
  }

}