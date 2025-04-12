import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Requete extends GetConnect {
  //
  static String url = "https://essabu.com/api/";
  //
  Future<http.Response> postETicket(String path, Map e) async {
    return http
        .post(
          Uri.parse("${Requete.url}$path"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(e),
        )
        .timeout(const Duration(minutes: 2));
  }

  Future<Response> getE(String path, String token) async {
    print("${Requete.url}$path");
    return get(
      "${Requete.url}$path",
      headers: {"Authorization": "Bearer $token"},
    );
  }

  Future<Response> postE(String path, var e, String token) async {
    print("${Requete.url}$path");
    return post(
      "${Requete.url}$path",
      headers: {"Authorization": "Bearer $token"},
      e,
    );
  }

  Future<Response> postEE(String path, Map e) async {
    print("${Requete.url}$path");
    var url = Uri.parse("${Requete.url}$path");
    var response = await post(
      "${Requete.url}$path",
      headers: {"Accept": "*/*"},
      jsonEncode(e),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return response;
  }

  Future<http.Response> putE(String path, dynamic e) async {
    print("${Requete.url}$path");
    var url = Uri.parse("${Requete.url}$path");
    var response = await http.put(
      url,
      body: jsonEncode(e),
      headers: {"Content-Type": "application/json"},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return response;
  }
}
