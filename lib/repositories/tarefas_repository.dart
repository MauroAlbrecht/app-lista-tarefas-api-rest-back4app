import 'package:app_tarefas_back4app/models/tarefa_model.dart';
import 'package:dio/dio.dart';

class TarefasRepository {
  var _dio = Dio();

  TarefasRepository() {
    _dio.options.headers['X-Parse-Application-Id'] = 'u1G39rCu2Yz4oxj23XdIbQ1Xl6ZuhPOfyY80zhwz';
    _dio.options.headers['X-Parse-REST-API-Key'] = 'kjA8zFWMVj7gvycpDVE52tjDxvMH8zNMM7Gqr3z0';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }

  Future<TarefasModel> getAll(bool naoConcluidas) async {
    var url = '/Tarefas';
    if (naoConcluidas) {
      url = '$url?where={\"concluido":false}';
    }
    var result = await _dio.get(url);
    return TarefasModel.fromJson(result.data);
  }

  Future<void> criar(TarefaModel tarefaModel) async {
    var url = '/Tarefas';
    await _dio.post(url, data: tarefaModel.toCreateJson());
  }

  Future<void> atualizar(TarefaModel tarefaModel) async {
    var url = '/Tarefas/${tarefaModel.objectId}';
    await _dio.put(url, data: tarefaModel.toCreateJson());
  }

  Future<void> remover(TarefaModel tarefaModel) async {
    var url = '/Tarefas/${tarefaModel.objectId}';
    await _dio.delete(url);
  }
}
