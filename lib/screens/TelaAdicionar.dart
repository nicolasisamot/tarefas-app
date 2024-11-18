import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/Tarefa.dart';
import '../data/TarefasDao.dart';

class TelaAdicionar extends StatefulWidget {
  const TelaAdicionar({super.key});

  @override
  State<TelaAdicionar> createState() => _TelaAdicionarState();
}

class _TelaAdicionarState extends State<TelaAdicionar> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Adicionar"),
      ),
      body: Container(
        width: 1000,
        height: 1000,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: nomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor insira um nome';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome da tarefa',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) => {setState(() {})},
                            keyboardType: TextInputType.text,
                            controller: fotoController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Url da foto',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 10),
                          Image.network(fotoController.text,
                              width: 100, height: 100,
                              errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              size: 100,
                            );
                          }),
                          SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Tarefa tarefa = Tarefa(
                                    nome: nomeController.text,
                                    foto: fotoController.text,
                                  );
                                  TarefasDao.adicionarRegistro(tarefa);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Tarefa adicionada!")));
                                }
                                Navigator.pop(context);
                              },
                              child: Text("Adicionar")),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
