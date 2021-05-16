import 'dart:convert';

import 'package:empresa_app/models/departamentos.dart';
import 'package:http/http.dart' as http;

class Connector {
  static var json;

  static Future<http.Response> fetchAlbum() {
    return http.get(Uri.http('192.168.1.161:3000', 'departamentos'));
  }

  static void test() async {
    try {
      print('entrou');
      var json = await fetchAlbum();
      var result = Departamento.fromJson(jsonDecode(json.body));
      print('saiu');
      print(result.id.toString() + " - " + result.nome);
    } catch (Exception) {
      print('erro');
      print(Exception);
    }
  }
}
