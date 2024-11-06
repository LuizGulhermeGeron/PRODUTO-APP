// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

String? dateTimeParaTexto(DateTime? inData) {
  if(inData != null){
    return "${inData.year}-${inData.month.toString().padLeft(2, '0')}-${inData.day.toString().padLeft(2, '0')}";
  }else{
    return null;
  }
}

// ignore: non_constant_identifier_names
DateTime? TextoParaDateTime(String? inTexto){
  if(inTexto != null){
    return DateTime(
      int.parse(inTexto.split("T")[0].split("-")[0]),
      int.parse(inTexto.split("T")[0].split("-")[1]),
      int.parse(inTexto.split("T")[0].split("-")[2]),
    );
  }else{
    return null;
  }
}

// ignore: non_constant_identifier_names
String? TextoParaData(String? inTexto){
  if(inTexto != null){
    return "${inTexto.split("-")[2]}/${inTexto.split("-")[1]}/${inTexto.split("-")[0]}";
  }else{
    return null;
  }
}

// ignore: non_constant_identifier_names
String? DataParaTexto(String? inTexto){
  if(inTexto != null){
    return "${inTexto.split("/")[2]}-${inTexto.split("/")[1]}-${inTexto.split("/")[0]}";
  }else{
    return null;
  }
}

aviso(BuildContext inContext, String inTexto){
  showDialog(context: inContext, builder: (BuildContext inContext){
    return AlertDialog(
      content: SizedBox(
        width: 600,
        child: ListView(
          shrinkWrap: true,
          children: [
            Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(inTexto),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(inContext);
                      },
                      child: const Text("Continuar")
                    ),
                  ]
                ),
              ],
            ),
          ]
        ),
      ),
    );
  });
}

acao(BuildContext inContext, Widget inConteudo, Widget inAcao){
  showDialog(context: inContext, builder: (BuildContext inContext){
    return AlertDialog(
      content: SizedBox(
        width: 600,
        child: ListView(
          shrinkWrap: true,
          children: [
            Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inConteudo,
                    Wrap(
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(inContext);
                          },
                          child: const Text("Cancelar")
                        ),
                        SizedBox(width: 20,),
                        inAcao,
                      ],
                    )
                  ]
                ),
              ],
            ),
          ]
        ),
      ),
    );
  });
}