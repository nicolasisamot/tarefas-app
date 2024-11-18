import 'package:sqflite/sqflite.dart';

import "../components/Tarefa.dart";
import './db.dart';

class TarefasDao {
  static const String tableSql = 'CREATE TABLE tarefas ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'nome TEXT,'
      'foto TEXT)';

  static Future<List<Tarefa>> pegarTodosRegistros() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> mapa = await db.query('tarefas');

    return toList(mapa);
  }

  static Future<void> adicionarRegistro(Tarefa tarefa) async {
    final Database db = await getDatabase();

    await db.insert('tarefas', {
      'id': tarefa.id,
      'nome': tarefa.nome,
      'foto': tarefa.foto,
    });
    print('Adicionado com sucesso!');
  }

  static Future<void> excluirRegistroPorId(int id) async {
    final Database db = await getDatabase();
    await db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }
}

List<Tarefa> toList(List<Map<String, dynamic>> mapa) {
  final List<Tarefa> tarefas = [];
  for (Map<String, dynamic> linha in mapa) {
    final Tarefa tarefa = Tarefa(
      id: linha['id'],
      nome: linha['nome'],
      foto: linha['foto'],
    );
    tarefas.add(tarefa);
  }
  return tarefas;
}
