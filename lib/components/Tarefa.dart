import 'package:flutter/material.dart';
import 'package:projeto_tarefas/data/TarefasDao.dart';

class Tarefa extends StatefulWidget {
  int? id;
  String nome;
  String foto;

  Tarefa({
    super.key,
    this.id,
    required this.nome,
    required this.foto,
  });

  @override
  State<Tarefa> createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 1000,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.foto, width: 120, height: 120,
                  errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 130,
                );
              }),
            ),
            Container(
              width: 140,
              child: Text(
                widget.nome,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  TarefasDao.excluirRegistroPorId(widget.id!);
                },
                child: Icon(Icons.check)),
          ],
        ),
      ),
    );
  }
}
