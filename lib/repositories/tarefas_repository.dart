import 'package:app_tarefas_back4app/models/tarefa_model.dart';
import 'package:dio/dio.dart';

class TarefasRepository {

  Future<TarefasModel> getAll (bool naoConcluidas) async {
    var dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] = 'u1G39rCu2Yz4oxj23XdIbQ1Xl6ZuhPOfyY80zhwz';
    dio.options.headers['X-Parse-REST-API-Key'] ='kjA8zFWMVj7gvycpDVE52tjDxvMH8zNMM7Gqr3z0' ;
    dio.options.headers['Content-Type'] = 'application/json';
    var url = 'https://parseapi.back4app.com/classes/Tarefas';
    if(naoConcluidas){
      url = '$url?where={\"concluido":false}';
    }
    var result = await dio.get(url);
    return TarefasModel.fromJson(result.data);
  }
}
