import 'package:cati_mobile/database/login_dao.dart';

import '../model/usuario.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioDAO {

  static Future<void> cadastrarCliente(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.15.9:8080/cati/cliente/cadastrarCliente'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toJson()),
      );

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          print('Cadastro bem-sucedido');
          final objeto = response.body;
        } else {
          print('Falha no cadastro: ${response.statusCode}');
        }
      } else {
        print('Resposta vazia do servidor');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

    static Future<bool> editar (Usuario usuario) async {

      final url = Uri.parse('http://192.168.15.9:8080/cati/cliente/editarCliente');
      print(jsonEncode(usuario.toJson()));
      String? token = await LoginDAO.getToken();
      try {
        final response = await http.put(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(usuario.toJsonDTO())
        );print(response.body);
        if (response.statusCode == 400) {
          return false;
        }
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }

    static Future<Usuario> buscaUsuario () async{
      final url = Uri.parse('http://192.168.15.9:8080/cati/cliente');
      print('oiiiii');
    String? token = await LoginDAO.getToken();
      try {
        final response = await http.get(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
        );
        print(response.body);
      return Usuario.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e);
        return Future.error(e);
      }
    }




























  static final List<Usuario> _usuarios = [];
  static void adicionar(Usuario u) {
    _usuarios.add(u);
  }
  static List<Usuario> get listarUsuarios {
    return _usuarios;
  }
  static void excluir(Usuario u) {
    _usuarios.remove(u);
  }
}
