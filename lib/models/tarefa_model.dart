class TarefasModel {
  List<TarefaModel> tarefas = [];

  TarefasModel(this.tarefas);

  TarefasModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <TarefaModel>[];
      json['results'].forEach((v) {
        tarefas.add(TarefaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.tarefas != null) {
      data['results'] = this.tarefas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TarefaModel {
  String objectId = '';
  String descricao = '';
  bool concluido = false;
  String createdAt = '';
  String updatedAt = '';

  TarefaModel(this.objectId, this.descricao, this.concluido, this.createdAt, this.updatedAt);

  TarefaModel.criar(this.descricao, this.concluido);

  TarefaModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = this.objectId;
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;
    return data;
  }
}
