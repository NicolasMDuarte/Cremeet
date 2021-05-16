import 'dart:io';

class Connector {
  static var json = HttpClient().get("192.168.1.161", 3000, "/departamentos");

  static void test() {
    json = HttpClient().get("192.168.1.161", 3000, "/departamentos");
    print(json);
  }
}
