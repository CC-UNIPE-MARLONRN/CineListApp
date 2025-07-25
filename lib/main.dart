import 'package:flutter/material.dart';
import 'package:CineListApp/view/listar_filmes.dart';

void main(){
  runApp(const AppFilmes());
}

class AppFilmes extends StatelessWidget {
  const AppFilmes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListarFilmes(),
    );
  }
}