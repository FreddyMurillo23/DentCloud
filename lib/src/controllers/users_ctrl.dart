//Peticiones de Usuarios
import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/services/conf.dart';

class UsuarioCtrl{
  static Future<bool> insertUser() async {
    http.Response response = await http.post(
      GlobalVars.apiUrl + "",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nombre': null,
        },
      ),
    ); 
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }
}