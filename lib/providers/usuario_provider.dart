import 'package:serav2/constants.dart';
import 'package:serav2/models/usuario.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

// ignore: camel_case_types
class Usuario_provider with ChangeNotifier {
  String email = "";
  String password = "";

  List<Usuario> usuarios = [];

  Usuario_provider() {
    getUsuarios();
  }

  getUsuarios() async {
    final url1 = Uri.http(urlapi, 'api/usuario');
    final resp = await http.get(url1, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    final response = usuarioFromJson(resp.body);
    usuarios = response;
    notifyListeners();
  }
}
