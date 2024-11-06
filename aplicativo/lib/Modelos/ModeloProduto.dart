import 'package:aplicativo/Ferramentas/ferramentas.dart';

class ModeloProduto{
  int? id;
  String? nome;
  DateTime? data = DateTime.now();
  String? descricao;
  int? estoque = 0;
  double? preco = 0;
  ModeloProduto.novo();
  ModeloProduto.mapa(Map<String, dynamic> inMapa){
    id = inMapa["id"];
    data = TextoParaDateTime(inMapa["data"]);
    descricao = inMapa["descricao"];
    estoque = inMapa["estoque"];
    preco = double.parse(inMapa["preco"].toString());
  }
  Map<String, dynamic> paraMapa(){
    return {
      "id" : id.toString(),
      "data" : dateTimeParaTexto(data),
      "descricao" : descricao,
      "estoque" : estoque.toString(),
      "preco" : preco.toString()
    };
  }
  @override
  String toString(){
    var temEstoque = false;
    if(estoque != null){
      if(estoque! > 0){
        temEstoque = true;
      }
    }

    if(temEstoque){
      return "$descricao $preco";
    }else{
      return "$descricao FORA DE ESTOQUE";
    }
  }
}