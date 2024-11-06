import 'dart:convert';

import 'package:aplicativo/Ferramentas/API.dart';
import 'package:aplicativo/Ferramentas/CRUD.dart';
import 'package:aplicativo/Modelos/ModeloProduto.dart';
import 'package:http/http.dart' as http;

class AcessoProduto extends AcessoCRUD<ModeloProduto>{
  List<ModeloProduto> lista = [];
  ModeloProduto? instancia;

  AcessoProduto(){
    listar();
  }

  @override
  criar(){
    instancia = ModeloProduto.novo();
  }

  @override
  excluir(ModeloProduto inInstancia) async {
    final response = await http.delete(API.URL('api/produtos/${inInstancia!.id}'));
    if (response.statusCode == 200) {
      listar();
    }else{
      print(response.statusCode);
    }
  }

  @override
  adicionar(ModeloProduto inInstancia) async {
    final response = await http.post(API.URL('api/produtos/'),body: jsonEncode(inInstancia?.paraMapa()), headers: {'Content-Type': 'application/json',},);
    if (response.statusCode == 201) {
      listar();
    }else{
      print(response.statusCode);
    }
  }

  @override
  editar(ModeloProduto inInstancia) async {
    final response = await http.put(API.URL('api/produtos/${inInstancia!.id}'),body: jsonEncode(inInstancia?.paraMapa()), headers: {'Content-Type': 'application/json',},);
    if (response.statusCode == 200) {
      listar();
    }else{
      print(response.statusCode);
    }
  }

  @override
  listar() async {
    final response = await http.get(API.URL('api/produtos'));
    if (response.statusCode == 200) {
      lista = jsonDecode(response.body).map<ModeloProduto>((inMapa){ return ModeloProduto.mapa(inMapa); }).toList();
      notifyListeners();
    }else{
      print(response.statusCode);
    }
  }
  
  @override
  Future recuperar(ModeloProduto inInstancia) async{
    final response = await http.get(API.URL('api/produtos/${inInstancia!.id}'));
    if (response.statusCode == 200) {
      instancia = ModeloProduto.mapa(jsonDecode(response.body));
      notifyListeners();
    }else{
      print(response.statusCode);
    }
  }
}

AcessoProduto acessoProduto = AcessoProduto();