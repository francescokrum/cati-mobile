class Usuario {

  String _nome = '';
  String _cpf = '';
  String _email = '';
  String _login = '';
  String _senha = '';
  String _cnpj_unidade = '';


  Map <String, dynamic> toJson () {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'login': login,
      'senha': senha,
      'cnpj_unidade': _cnpj_unidade
    };
  }

  Usuario.vazio();

  Map <String, dynamic> toJsonDTO () {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'login': login,
      'cnpj_unidade': _cnpj_unidade
    };
  }

  Usuario.DTO({
    required String nome,
    required String cpf,
    required String email,
    required String login,
    required String cnpj_unidade,
  })   : _nome = nome,
        _cpf = cpf,
        _email = email,
        _login = login,
        _cnpj_unidade = cnpj_unidade;

  Usuario.fromJson(Map<String, dynamic> json) {
    _nome = json['nome'] ?? '';
    _cpf = json['cpf'] ?? '';
    _email = json['email'] ?? '';
    _login = json['login'] ?? '';
    _senha = json['senha'] ?? '';
    _cnpj_unidade = json['cnpj_unidade'] ?? '';
  }

  Usuario({
    required String nome,
    required String cpf,
    required String email,
    required String login,
    required String senha,
    required String cnpj_unidade,
  })   : _nome = nome,
        _cpf = cpf,
        _email = email,
        _login = login,
        _senha = senha,
        _cnpj_unidade = cnpj_unidade;

  // Getters

  String get nome => _nome;

  String get cpf => _cpf;

  String get email => _email;

  String get login => _login;

  String get senha => _senha;

  String get cnpj_unidade => _cnpj_unidade;

  // Setters
  set nome(String value) {
    _nome = value;
  }

  set cpf(String value) {
    _cpf = value;
  }

  set email(String value) {
    _email = value;
  }

  set login(String value) {
    _login = value;
  }

  set senha(String value) {
    _senha = value;
  }

  set cnpj_unidade(String value) {
    _cnpj_unidade = value;
  }
}
