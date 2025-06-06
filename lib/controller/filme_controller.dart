import 'package:app_filmes/model/filme.dart';
import 'package:app_filmes/service/filme_service.dart';

class FilmeController{
  final _service = FilmeService();

  Future<List<Filme>?> findAll() async{
    return await _service.findAll();
  }

  Future<int?> save(String url_imagem, String titulo, String genero, String faixa_etaria, int duracao, double pontuacao, String descricao, int ano) async{
    return await _service.save(Filme(url_imagem: url_imagem, titulo: titulo, genero: genero, faixa_etaria: faixa_etaria, duracao: duracao, pontuacao: pontuacao, descricao: descricao, ano: ano));
  }

  Future<int?> alter(String url_imagem, String titulo, String genero, String faixa_etaria, int duracao, double pontuacao, String descricao, int ano) async{
    return await _service.alter(Filme(url_imagem: url_imagem, titulo: titulo, genero: genero, faixa_etaria: faixa_etaria, duracao: duracao, pontuacao: pontuacao, descricao: descricao, ano: ano));
  }

  Future<int?> remove(Filme filme) async {
    return await _service.remove(filme);
  }
}