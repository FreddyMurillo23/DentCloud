import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/userPatients_models.dart';
import 'package:http/http.dart' as http;

class UserPatient with ChangeNotifier {
  List<Paciente> usuario = [];

  UserPatient() {
    this.getUserData();
  }

  getUserData() async {
    final url =
        "http://54.197.83.249/PHP_REST_API/api/get/get_patients_by_business.php?business_ruc=1304924424001";
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final userPatient = userPatientsFromJson(resp.body);
      this.usuario.addAll(userPatient.pacientes);
      notifyListeners();
    } else {
      throw Exception('Failed');
    }
  }
}
