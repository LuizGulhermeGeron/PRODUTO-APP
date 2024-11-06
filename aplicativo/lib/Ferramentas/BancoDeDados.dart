import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _BancoDeDados{
  late Future<Database> bancoDeDados;

  _BancoDeDados(){
    bancoDeDados = iniciar();
  } 

  Future<Database> iniciar()async{
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.linux)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    String local = join((await getApplicationDocumentsDirectory()).path, "BancoDeDados6.db");
    return openDatabase(
      local,
      version: 1,
      onOpen: (db){},
      onCreate: (Database inBancoDeDados, int inVersao)async{
        await inBancoDeDados.execute("""
          create table if not exists aniversario(
            id integer primary key,
            nome text,
            nascimento date,
            lembretes text
          )
        """);
      }
    );
  }
}

_BancoDeDados bancoDeDados = _BancoDeDados();