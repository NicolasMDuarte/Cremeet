import 'package:http/http.dart' as http;

class Connector {
  static var json;

  static Future<http.Response> fetchAlbum() {
    var url = "192.168.1.161";
    return http.get(Uri.https(url, 'departamentos'));
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
