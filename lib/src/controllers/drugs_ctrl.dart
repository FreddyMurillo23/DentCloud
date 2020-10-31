import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/medicinas_model.dart';

class DrugsCtrl{
  static Future<List<MedicinasModelo>> listarMedicinasByName(String drugname) async{
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_drug_data.php?drug_name=$drugname");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed['servicios'].map<MedicinasModelo>((json) => MedicinasModelo.fromJson(json)).toList();
    }
    return null;
  }
}