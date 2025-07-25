import 'package:CineListApp/view/cadastrar_filme.dart';
import 'package:CineListApp/view/detalhar_filme.dart';
import 'package:CineListApp/view/alterar_filme.dart';
import 'package:flutter/material.dart';
import 'package:CineListApp/controller/filme_controller.dart';
import 'package:CineListApp/model/filme.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({super.key});

  @override
  State<ListarFilmes> createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  final _filmesController = FilmeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filmes",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Autor", textAlign: TextAlign.center,),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  "https://avatars.githubusercontent.com/u/162641166?v=4",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Desenvolvido por",
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Marlon Rufino do Nascimento",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/25/25231.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                  Text(" CC-UNIPE-MARLONRN")
                                ],
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Ok", style: TextStyle(color: Colors.blue),),
                            ),
                          ],
                        ),
                      );
                    }, icon: const Icon(Icons.info, color: Colors.white)),
              ]
          ), backgroundColor: Colors.blue
      ),
      body: FutureBuilder(
          future: _filmesController.findAll(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              final filmes = snapshot.data;
              return ListView.builder(
                itemCount: filmes!.length,
                itemBuilder: (context, index) {
                  return buildItemList(filmes[index]);
                },
              );
            } else if(snapshot.hasError){
              return const Center(
                child: Text("Erro ao Carregar a Lista de Filmes"),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const CadastrarFilme();
          })).then((value){
            setState(() {
            });
          });
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget buildItemList(Filme filme) {
    return Dismissible(
      key: ValueKey(filme.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        bool confirm = await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirmar'),
            content: const Text('Tem certeza que deseja excluir este filme?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Excluir'),
              ),
            ],
          ),
        );
        if (confirm) {
          final sucesso = await _filmesController.remove(filme);
          if (sucesso != null) {
            setState(() {
              _filmesController.remove(filme);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Excluído com sucesso!')),
            );
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erro ao excluir o filme.')),
            );
            return false;
          }
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Exibir Dados', textAlign: TextAlign.center),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalharFilme(filme: filme),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Alterar', textAlign: TextAlign.center),
                      onTap: () async {
                        Navigator.pop(context);
                        final filmeAtualizado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlterarFilme(filme: filme),
                          ),
                        );
                        if (filmeAtualizado != null) {
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    filme.url_imagem,
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 100,
                      height: 140,
                      color: Colors.grey,
                      child: const Icon(Icons.broken_image, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filme.titulo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        filme.genero,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(filme.duracao ~/ 60)}h ${(filme.duracao % 60)}min',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 25),
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
