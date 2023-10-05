import 'package:app_tarefas_back4app/models/tarefa_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'back4app_custom_dio.dart';

class TarefasRepository {

  final _dioCustom = Back4appCustomDio();

  Future<TarefasModel> getAll(bool naoConcluidas) async {
    var url = '/Tarefas';
    if (naoConcluidas) {
      url = '$url?where={\"concluido":false}';
    }
    var result = await _dioCustom.dio.get(url);
    return TarefasModel.fromJson(result.data);
  }

  Future<void> criar(TarefaModel tarefaModel) async {
    var url = '/Tarefas';
    await _dioCustom.dio.post(url, data: tarefaModel.toCreateJson());
  }

  Future<void> atualizar(TarefaModel tarefaModel) async {
    var url = '/Tarefas/${tarefaModel.objectId}';
    await _dioCustom.dio.put(url, data: tarefaModel.toCreateJson());
  }

  Future<void> remover(TarefaModel tarefaModel) async {
    var url = '/Tarefas/${tarefaModel.objectId}';
    await _dioCustom.dio.delete(url);
  }
}
