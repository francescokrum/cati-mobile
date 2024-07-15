class login {

  String _loginUsuario;
  String _senha;


  login(this._loginUsuario, this._senha);


  String get loginUsuario => _loginUsuario;

  set loginUsuario(String value) {
    _loginUsuario = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

}
