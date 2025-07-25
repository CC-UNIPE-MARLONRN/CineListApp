import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:CineListApp/model/filme.dart';
import '../service/filme_service.dart';

class AlterarFilme extends StatefulWidget {
  final Filme filme;
  const AlterarFilme({super.key, required this.filme});

  @override
  State<AlterarFilme> createState() => _AlterarFilmeState();
}

class _AlterarFilmeState extends State<AlterarFilme> {
  final _key = GlobalKey<FormState>();
  final _edt_url_imagem = TextEditingController();
  final _edt_titulo = TextEditingController();
  final _edt_genero = TextEditingController();
  final _edt_duracao = TextEditingController();
  final _edt_descricao = TextEditingController();
  final _edt_ano = TextEditingController();
  final _filmeService = FilmeService();

  List<String> faixa_etaria = ["Livre", "10", "12", "14", "16", "18"];
  String faixaEtariaSelecionada = "Livre";
  double notaSelecionada = 5;

  @override
  void initState() {
    super.initState();
    _edt_url_imagem.text = widget.filme.url_imagem;
    _edt_titulo.text = widget.filme.titulo;
    _edt_genero.text = widget.filme.genero;
    _edt_duracao.text = widget.filme.duracao.toString();
    _edt_descricao.text = widget.filme.descricao;
    _edt_ano.text = widget.filme.ano.toString();
    faixaEtariaSelecionada = widget.filme.faixa_etaria;
    notaSelecionada = widget.filme.pontuacao.toDouble();
  }

  @override
  void dispose() {
    _edt_url_imagem.dispose();
    _edt_titulo.dispose();
    _edt_genero.dispose();
    _edt_duracao.dispose();
    _edt_descricao.dispose();
    _edt_ano.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Alterar Filme", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _edt_url_imagem,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(labelText: "Url Imagem", labelStyle: TextStyle(color: Colors.black54)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edt_titulo,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Título", labelStyle: TextStyle(color: Colors.black54)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edt_genero,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Gênero", labelStyle: TextStyle(color: Colors.black54)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    const Text("Faixa Etária: ", style: TextStyle(fontSize: 16, color: Colors.black54)),
                    DropdownButton<String>(
                      value: faixaEtariaSelecionada,
                      hint: const Text("Livre"),
                      items: faixa_etaria.map((String valor) => DropdownMenuItem(value: valor, child: Text(valor))).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          faixaEtariaSelecionada = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _edt_duracao,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Duração (minutos)", labelStyle: TextStyle(color: Colors.black54)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("Nota: ", style: TextStyle(color: Colors.black54)),
                    RatingBar.builder(
                      initialRating: notaSelecionada,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(Icons.star_border, color: Colors.blue),
                      onRatingUpdate: (rating) {
                        setState(() {
                          notaSelecionada = rating;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _edt_ano,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Ano", labelStyle: TextStyle(color: Colors.black54)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edt_descricao,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: "Descrição", labelStyle: TextStyle(color: Colors.black54)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () {
          final valid = _key.currentState!.validate();
          if (!valid) {
            return;
          }
          int duracaoFilme = int.parse(_edt_duracao.text);
          int anoFilme = int.parse(_edt_ano.text);
          final filmeAlterado = Filme(
            id: widget.filme.id,
            url_imagem: _edt_url_imagem.text,
            titulo: _edt_titulo.text,
            genero: _edt_genero.text,
            duracao: duracaoFilme,
            descricao: _edt_descricao.text,
            ano: anoFilme,
            faixa_etaria: faixaEtariaSelecionada,
            pontuacao: notaSelecionada,
          );
          _filmeService.alter(filmeAlterado).then((result) {
            if (result != null && result > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Alterado com Sucesso")));
              Navigator.pop(context, filmeAlterado);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Erro ao alterar filme')),
              );
            }
          });
        },
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}
