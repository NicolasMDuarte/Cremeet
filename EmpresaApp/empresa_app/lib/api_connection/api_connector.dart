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
      print('saiu');
      print(json);
    } catch (Exception) {
      print('erro');
      print(Exception);
    }
  }
}
