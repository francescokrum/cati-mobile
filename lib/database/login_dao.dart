import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginDAO {
  static final storage = FlutterSecureStorage();

  static Future<bool> login(String login, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.15.9:8080/cati/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login': login,
          'senha': senha,
        }),
      );

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          print('Login bem-sucedido');
          final token = response.body; // Supondo que o corpo da resposta seja apenas o token em string
          await setToken(token); // Armazene o token usando a função setToken
          return true;
        } else {
          print('Falha no login: ${response.statusCode}');
          return false;
        }
      } else {
        print('Resposta vazia do servidor');
        return false;
      }
    } catch (e) {
      print('Erro: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  static Future<void> setToken(String token) async {
    print('Armazenando token: $token');
    await storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
