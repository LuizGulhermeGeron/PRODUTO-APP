import 'package:aplicativo/Acessos/AcessoProduto.dart';
import 'package:aplicativo/Ferramentas/CRUD.dart';
import 'package:aplicativo/Fomularios/FormularioProduto.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: TelaCRUD(acesso: acessoProduto, formulario: FormularioProduto(acesso: acessoProduto)),
    );
  }
}