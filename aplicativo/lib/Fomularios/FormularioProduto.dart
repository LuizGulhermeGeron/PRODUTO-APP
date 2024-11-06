import 'package:aplicativo/Acessos/AcessoProduto.dart';
import 'package:aplicativo/Ferramentas/BInputs.dart';
import 'package:aplicativo/Ferramentas/CRUD.dart';
import 'package:flutter/material.dart';

class FormularioProduto extends FormularioCRUD{

  FormularioProduto({required super.acesso});

  @override
  Widget formulario() {
    this.chaveFormulario = GlobalKey();
    return Form(
      key: chaveFormulario,
      child: Column(
        children: [
          Container(height: 20,),
          TextFormField(
            enabled: editavel,
            initialValue: acesso.instancia!.descricao,
            decoration: const InputDecoration(
              labelText: "Descrição", 
            ),
            validator: (String? inTexto){
              if(inTexto == ""){
                return "Obrigatório";
              }
              return null;
            },
            onSaved: (String? inTexto){
              acesso.instancia!.descricao = inTexto;
            },
          ),
          Container(height: 20,),
          BData(
            editavel: editavel,
            nome: 'Data',
            inInicial: acesso.instancia!.data,
            onSaved: (DateTime? inData){
              acesso.instancia!.data = inData;
            },
            validator: (DateTime? inData){
              if(inData == null){
                return "Obrigatório";
              }
              return null;
            },
          ),
          Container(height: 20,),
          TextFormField(
            enabled: editavel,
            initialValue: acessoProduto.instancia!.preco.toString(),
            decoration: const InputDecoration(
              labelText: "Preço", 
            ),
            validator: (String? inTexto){
              if(inTexto == ""){
                return "Obrigatório";
              }
              try{
                double.parse(inTexto!);
              }catch(e){
                return "Não é um número válido";
              }
              return null;
            },
            onSaved: (String? inTexto){
              acessoProduto.instancia!.preco = double.parse(inTexto!);
            },
          ),
          Container(height: 20,),
          TextFormField(
            enabled: editavel,
            initialValue: acessoProduto.instancia!.estoque.toString(),
            decoration: const InputDecoration(
              labelText: "Estoque", 
            ),
            validator: (String? inTexto){
              if(inTexto == ""){
                return "Obrigatório";
              }
              try{
                int.parse(inTexto!);
              }catch(e){
                return "Não é um número válido";
              }
              return null;
            },
            onSaved: (String? inTexto){
              acessoProduto.instancia!.estoque = int.parse(inTexto!);
            },
          ),
        ],
      ),
    );
  }

}

