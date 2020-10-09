import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/userData_models.dart';
import 'package:http/http.dart' as http;

class UserData with ChangeNotifier {
  List<Usuario> usuario = [];

  UserData() {
    this.getUserData();
  }

  getUserData() async {
    final url =
        "http://54.197.83.249/PHP_REST_API/api/get/get_select_user_data_global.php";
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final newsUser = newsUserFromJson(resp.body);
      this.usuario.addAll(newsUser.usuario);
      notifyListeners();
    } else {
      throw Exception('Failed');
    }
  }
}
