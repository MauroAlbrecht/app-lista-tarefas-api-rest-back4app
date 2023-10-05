import 'package:flutter/material.dart';

import '../models/tarefa_model.dart';
import '../repositories/tarefas_repository.dart';

class TarefasPage extends StatefulWidget {
  @override
  _TarefasPageState createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  var tarefaRepository = TarefasRepository();

  var descricaoController = TextEditingController();
  var _tarefas = TarefasModel([]);
  var naoConcluidas = false;
  var loading = false;

  @override
  void initState() {
    carregaTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista Tarefas - Back4App'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          descricaoController.text = '';

          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text('Adiconar Tarefa'),
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          tarefaRepository.criar(TarefaModel.criar(descricaoController.text, false));
                          carregaTarefas();
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text('Salvar')),
                  ],
                );
              });
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Apenas não concluídos',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                    value: naoConcluidas,
                    onChanged: (bool val) async {
                      naoConcluidas = val;
                      await carregaTarefas();
                      setState(() {});
                    })
              ],
            ),
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                        itemCount: _tarefas.tarefas.length,
                        itemBuilder: (BuildContext bc, int index) {
                          return Dismissible(
                            key: Key(_tarefas.tarefas[index].descricao),
                            child: ListTile(
                              title: Text(_tarefas.tarefas[index].descricao),
                              trailing: Switch(
                                onChanged: (bool val) async {
                                  _tarefas.tarefas[index].concluido = val;
                                  await tarefaRepository.atualizar(_tarefas.tarefas[index]);
                                  setState(() {});
                                },
                                value: _tarefas.tarefas[index].concluido,
                              ),
                            ),
                            onDismissed: (DismissDirection dis) {
                               tarefaRepository.remover(_tarefas.tarefas[index]);
                              carregaTarefas();
                            },
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> carregaTarefas() async {
    setState(() {
      loading = true;
    });
    _tarefas = await tarefaRepository.getAll(naoConcluidas);
    setState(() {
      loading = false;
    });
  }
}
