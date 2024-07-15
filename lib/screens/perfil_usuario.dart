import 'package:flutter/material.dart';
import '../model/usuario.dart';
import '../database/usuario_dao.dart';
import 'login_screen.dart';

class PerfilUsuario extends StatefulWidget {

  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {

   Usuario usuarioVazio = Usuario.vazio();

   TextEditingController _nomeController = TextEditingController();
   TextEditingController _cpfController = TextEditingController();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _loginController = TextEditingController();
   TextEditingController _cnpj_unidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dadosPerfil();
  }

  Future<void> dadosPerfil() async{

    try{

      Usuario usuarioBanco = await UsuarioDAO.buscaUsuario();

      setState(() {
        _nomeController.text = usuarioBanco.nome;
        _cpfController.text = usuarioBanco.cpf;
        _emailController.text = usuarioBanco.email;
        _loginController.text = usuarioBanco.login;
        _cnpj_unidadeController.text = usuarioBanco.cnpj_unidade;

      });

      usuarioVazio.nome = usuarioBanco.nome;
      usuarioVazio.cpf = usuarioBanco.cpf;
      usuarioVazio.email = usuarioBanco.email;
      usuarioVazio.login = usuarioBanco.login;
      usuarioVazio.cnpj_unidade = usuarioBanco.cnpj_unidade;

    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Central de Atendimento de TI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                onChanged: (text){
                usuarioVazio.nome = text;
              },
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (text){
                usuarioVazio.cpf = text;
              },
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (text){
                  usuarioVazio.email = text;
                },
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (text){
                  usuarioVazio.login = text;
                },
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (text){
                  usuarioVazio.cnpj_unidade = text;
                },
                controller: _cnpj_unidadeController,
                decoration: const InputDecoration(labelText: 'CNPJ da Empresa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                    UsuarioDAO.editar(usuarioVazio);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuário editado com sucesso!'),
                      ),
                    );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                ),
                child: const Text(
                  'EDITAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
