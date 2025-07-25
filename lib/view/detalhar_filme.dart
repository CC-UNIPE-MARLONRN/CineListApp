import 'package:flutter/material.dart';
import 'package:CineListApp/model/filme.dart';

class DetalharFilme extends StatelessWidget {
  final Filme filme;

  const DetalharFilme({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Detalhes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: Image.network(
                filme.url_imagem,
                width: 180,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 180,
                  height: 250,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filme.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${filme.genero}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(filme.duracao ~/ 60)}h ${(filme.duracao % 60)}min',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${filme.ano}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),

                    if(filme.faixa_etaria != "Livre")
                    Text(
                      '${filme.faixa_etaria} anos',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    if(filme.faixa_etaria == "Livre")
                    const Text(
                      'Livre',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      )
                    ),
                    const SizedBox(height: 8),

                    // Estrelas
                    Row(
                      children: List.generate(5, (index) {
                        if (filme.pontuacao >= index + 1) {
                          return const Icon(Icons.star, color: Colors.amber, size: 20);
                        } else if (filme.pontuacao > index) {
                          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
                        } else {
                          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),


            const SizedBox(height: 12),

            // Descrição
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  filme.descricao.isNotEmpty
                      ? filme.descricao
                      : 'Sem descrição disponível.',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
