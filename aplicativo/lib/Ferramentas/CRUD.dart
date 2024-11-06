
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class AcessoCRUD<T> extends Model{
    List<T> lista = [];
    T? instancia;

    criar();
    adicionar(T inInstancia);
    excluir(T inInstancia);
    editar(T inInstancia);
    listar();
    Future recuperar(T inInstancia);
}

// ignore: must_be_immutable
abstract class FormularioCRUD{
  GlobalKey<FormState> chaveFormulario = GlobalKey();
  final AcessoCRUD acesso;
  Widget formulario();
  bool editavel = true;
  FormularioCRUD({required this.acesso});
}

// ignore: must_be_immutable
abstract class AcoesCRUD extends StatelessWidget{
  final FormularioCRUD formulario;
  final AcessoCRUD acesso;
	const AcoesCRUD({super.key, required this.acesso, required this.formulario});
}

// ignore: must_be_immutable
class ModalCRUD extends StatelessWidget{
  final FormularioCRUD formulario;
	final AcoesCRUD acoes;

    const ModalCRUD({super.key, required this.formulario, required this.acoes});

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            width: 600,
            child: ListView(
				shrinkWrap: true,
                children: [
                    Wrap(
                        children: [
                            formulario.formulario(),
							acoes,
                        ],
                    ),
                ],
            ),
        );
    }
}

// ignore: must_be_immutable
class AcoesEditarCRUD extends AcoesCRUD{
	const AcoesEditarCRUD({super.key, required super.acesso, required super.formulario});
    @override
	Widget build(BuildContext context) {
		return Wrap(
			children: [
				TextButton(
					onPressed: (){
						Navigator.pop(context);
					},
					child: const Text("Cancelar"),
				),
        Container(width: 20,),
                TextButton(
					onPressed: (){
						if(formulario.chaveFormulario.currentState!.validate()){
							formulario.chaveFormulario.currentState!.save();
							acesso.editar(acesso.instancia);
							Navigator.pop(context);
						}
					},
					child: const Text("Editar"),
				),
			],
		);
	}
}

// ignore: must_be_immutable
class AcoesExcluirCRUD extends AcoesCRUD{
	const AcoesExcluirCRUD({super.key, required super.acesso, required super.formulario});
    @override
	Widget build(BuildContext context) {
		return Wrap(
			children: [
				TextButton(
					onPressed: (){
						Navigator.pop(context);
					},
					child: const Text("Cancelar"),
				),
        Container(width: 20,),
                TextButton(
					onPressed: (){
						acesso.excluir(acesso.instancia);
						Navigator.pop(context);
					},
					child: const Text("Excluir"),
				),
			],
		);
	}
}

// ignore: must_be_immutable
class AcoesAdicionarCRUD extends AcoesCRUD{
	const AcoesAdicionarCRUD({super.key, required super.acesso, required super.formulario});
    @override
	Widget build(BuildContext context) {
		return Wrap(
			children: [
				TextButton(
					onPressed: (){
						Navigator.pop(context);
					},
					child: const Text("Cancelar"),
				),
        Container(width: 20,),
                TextButton(
					onPressed: (){
						if(formulario.chaveFormulario.currentState!.validate()){
							formulario.chaveFormulario.currentState!.save();
							acesso.adicionar(acesso.instancia);
							Navigator.pop(context);
						}
					},
					child: const Text("adicionar"),
				),
			],
		);
	}
}

// ignore: must_be_immutable
class AcoesVisualizarCRUD extends AcoesCRUD{
	const AcoesVisualizarCRUD({super.key, required super.acesso, required super.formulario});
    @override
	Widget build(BuildContext context) {
		return Wrap(
			children: [
				TextButton(
					onPressed: (){
						Navigator.pop(context);
					},
					child: const Text("Continuar"),
				),
        Container(width: 20,),
                TextButton(
					onPressed: (){
						Navigator.pop(context);
						showDialog(context: context, builder: (BuildContext inContext){
              formulario.editavel = true;
							return AlertDialog(content: ModalCRUD(formulario: formulario, acoes: AcoesEditarCRUD(acesso: acesso, formulario: formulario),));
						});
					},
					child: const Text("Editar"),
				),
        Container(width: 20,),
				TextButton(
					onPressed: (){
						Navigator.pop(context);
						showDialog(context: context, builder: (BuildContext inContext){
              formulario.editavel = false;
							return AlertDialog(content: ModalCRUD(formulario: formulario, acoes: AcoesExcluirCRUD(acesso: acesso, formulario: formulario),));
						});
					},
					child: const Text("Excluir"),
				),
			],
		);
	}
}

// ignore: must_be_immutable
class TelaCRUD extends StatelessWidget{
	final FormularioCRUD formulario;
  final AcessoCRUD acesso;

	const TelaCRUD({super.key, required this.acesso, required this.formulario});

  @override
  Widget build(BuildContext context) {
	return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 35, 20),
        child: ScopedModel<AcessoCRUD<dynamic>>(
          model: acesso,
          child: ScopedModelDescendant(
            builder: (BuildContext inContext, Widget? inWidget, AcessoCRUD inAcesso){
              return ListView(
                children: inAcesso.lista.map((dynamic inInstancia){
                  return Wrap(
                    children: [
                      Wrap(
                        children: [
                          TextButton(
                            child: Text(inInstancia.toString()),
                            onPressed: (){
                              inAcesso.recuperar(inInstancia).then((e){
                                showDialog(context: context, builder: (BuildContext inContext){
                                  formulario.editavel = false;
                                  return AlertDialog(content: ModalCRUD(formulario: formulario, acoes: AcoesVisualizarCRUD(acesso: acesso, formulario: formulario),));
                                });
							                });
                            },
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                    ]
                  );
                }).toList(),
              );
            }
          ),
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: (){
            showDialog(context: context, builder: (BuildContext inContext){
              acesso.criar() ;
              formulario.editavel = true;
				      return AlertDialog(content: ModalCRUD(formulario: formulario, acoes: AcoesAdicionarCRUD(acesso: acesso, formulario: formulario),));
			      });
        }
      ),
    );
  }
}