import 'package:flutter/material.dart';
import '../components/Tarefa.dart';
import './TelaAdicionar.dart';
import '../data/TarefasDao.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  void atualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tarefas"),
        //  actions: [
        //    IconButton(
        //       onPressed: () {
        //        setState(() {});
        //    },
        //  icon: const Icon(Icons.refresh))
        //],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 80),
          child: FutureBuilder<List<Tarefa>>(
              future: TarefasDao.pegarTodosRegistros(),
              builder: (context, snapshot) {
                List<Tarefa>? tarefas = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData && tarefas != null) {
                      return ListView.builder(
                          itemCount: tarefas.length,
                          itemBuilder: (context, index) {
                            return Tarefa(
                              id: tarefas[index].id,
                              nome: tarefas[index].nome,
                              foto: tarefas[index].foto,
                              onDelete: atualizar,
                            );
                          });
                    }
                    return Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                    );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TelaAdicionar();
          })).then((context) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
