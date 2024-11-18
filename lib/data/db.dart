import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projeto_tarefas/data/TarefasDao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(
    path,
    version: 2,
    onCreate: (Database db, int version) async {
      await db.execute(TarefasDao.tableSql);
    },
  );
}
