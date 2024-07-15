import '../model/chamado.dart';
import 'login_dao.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChamadoDAO {

  static Future<void> cadastrarChamado(Chamado chamado) async {
    print(jsonEncode(chamado.toJson()));
    try {
      String? token = await LoginDAO.getToken();
      final response = await http.post(
        Uri.parse('http://192.168.15.9:8080/cati/chamado/cadastrarChamado'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',

        },
        body: jsonEncode(chamado.toJson()),
      );

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          print('Chamado solicitado');
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

  static Future<List<Chamado>> buscaChamadosPorCliente() async {
    final url = Uri.parse('http://192.168.15.9:8080/cati/chamado/buscarChamadoPorCliente');
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
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Chamado> chamados = jsonList.map((e) => Chamado.fromJson(e)).toList();
        return chamados;
      } else {
        throw Exception('Failed to load chamados');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

// Métodos adicionais, se necessário
}
