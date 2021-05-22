import 'dart:collection';
import 'dart:convert';
import 'package:empresa_app/models/departamentos.dart';
import 'package:empresa_app/models/equipes.dart';
import 'package:empresa_app/models/eventos.dart';
import 'package:empresa_app/models/funcionarios.dart';
import 'package:empresa_app/models/locais.dart';
import 'package:empresa_app/models/times.dart';
import 'package:empresa_app/models/tipos_eventos.dart';
import 'package:http/http.dart' as http;

class Connector {
  static var json;
  static var ip = "cremeet-api.herokuapp.com";

  static Future<bool> connectGet() async {
    try {
      json = await http.get(Uri.http(ip, 'departamentos'));
      Departamento.fromJson(jsonDecode(json.body));
      json = await http.get(Uri.http(ip, 'equipes'));
      Equipe.fromJson(jsonDecode(json.body));
      json = await http.get(Uri.http(ip, 'eventos'));
      Evento.fromJson(jsonDecode(json.body));
      json = await http.get(Uri.http(ip, 'funcionarios'));
      Funcionario.fromJson(jsonDecode(json.body));
      json = await http.get(Uri.http(ip, 'locais'));
      Local.fromJson(jsonDecode(json.body));
      json = await http.get(Uri.http(ip, 'times'));
      Time.fromJson(jsonDecode(json.body));
      json = await http.get(Uri.http(ip, 'tipos'));
      TiposEventos.fromJson(jsonDecode(json.body));
    } catch (Exception) {
      print(Exception);
    }
    return true;
  }

  static Future<bool> connectPost(Evento evento) async {
    try {
      Map<String, String> headers = new HashMap();
      headers['Accept'] = 'application/json';
      headers['Content-type'] = 'application/json';

      http.post(Uri.http(ip, 'eventos'),
          headers: headers, body: jsonEncode(evento.toJson()));
    } catch (Exception) {
      print(Exception);
    }
    return true;
  }

  static Future<bool> connectDelete(var id) async {
    try {
      Map<String, String> headers = new HashMap();
      headers['Accept'] = 'application/json';
      headers['Content-type'] = 'application/json';

      http.delete(Uri.http(ip, 'eventos/' + id.toString()), headers: headers);
    } catch (Exception) {
      print(Exception);
    }
    return true;
  }
}
