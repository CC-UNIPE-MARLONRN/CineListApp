//Deve ser cadastrado as informações de id, url da imagem, título, gênero, faixa etária, duração, pontuação, descrição e ano.

class Filme{
  int? id;
  String url_imagem;
  String titulo;
  String genero;
  String faixa_etaria;
  int duracao;
  double pontuacao;
  String descricao;
  int ano;

  Filme({this.id, required this.url_imagem, required this.titulo, required this.genero, required this.faixa_etaria, required this.duracao, required this.pontuacao, required this.descricao, required this.ano});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url_imagem': url_imagem,
      'titulo' : titulo,
      'genero': genero,
      'faixa_etaria': faixa_etaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano
    };
  }

  factory Filme.fromMap(Map<String, dynamic> map){
    return Filme(
      id: map['id'] as int?,
      url_imagem: map['url_imagem'] ?? '',
      titulo: map['titulo'] ?? '',
      genero: map['genero'] ?? '',
      faixa_etaria: map['faixa_etaria'] ?? '',
      duracao: map['duracao'] ?? 0,
      pontuacao: (map['pontuacao'] as num?)?.toDouble() ?? 0.0,
      descricao: map['descricao'] ?? '',
      ano: map['ano'] ?? 0,
    );
  }

  @override
  String toString(){
    return "[Titulo: $titulo, Genero: $genero, Faixa Etária: $faixa_etaria, Duração: $duracao, Pontuação: $pontuacao, Descrição: $descricao, Ano: $ano]";
  }

}