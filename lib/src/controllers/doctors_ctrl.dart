import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/doctors_model.dart';

class DoctorCtrl{

    static Future<List<Doctores>> listarDoctores() async {
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_all_doctors.php");
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body).cast<String, dynamic>();
      print("object");
      return parsed['doctores_datos'].map<Doctores>((json) => Doctores.fromJson(json)).toList();
    }
    print("object");
    return null;
  }
}