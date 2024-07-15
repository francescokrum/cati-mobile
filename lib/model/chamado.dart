class Chamado {

  int _id = 0;
  String  _titulo = '';
  String _descricao = '';
  String _status = '';
  String _gravidade = '';
  dynamic _recurso = '';

  Chamado.fromJson(Map<String, dynamic> json) {
    _titulo = json['titulo'] ?? '';
    _descricao = json['descricao'] ?? '';
    _status = json['status'] ?? '';
    _gravidade = json['gravidade'] ?? '';
  }

  Map <String, dynamic> toJson () {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'gravidade': gravidade,
      'recurso': recurso,
    };
  }

  Chamado({
    required String titulo,
    required String descricao,
    required String gravidade,
  })   : _titulo = titulo,
        _descricao = descricao,
        _gravidade = gravidade;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get titulo => _titulo;

  dynamic get recurso => _recurso;

  set recurso(dynamic value) {
    _recurso = value;
  }

  String get gravidade => _gravidade;

  set gravidade(String value) {
    _gravidade = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  set titulo(String value) {
    _titulo = value;
  }
}