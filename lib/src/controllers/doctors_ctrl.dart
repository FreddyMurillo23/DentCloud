import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/doctors_model.dart';

class DoctorCtrl{

//General
  static Future<List<Doctores>> listarDoctores() async {
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_all_doctors.php");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed['doctores_datos'].map<Doctores>((json) => Doctores.fromJson(json)).toList();
    }
    return null;
  }

//Para el Search
  static Future<List<Doctores>> listarPrueba(String name) async {
      List<Doctores> noJodas = [];
      final response =  await http.get('http://54.197.83.249/PHP_REST_API/api/get/get_doctor_by_name.php?doctor_names=$name');
      if(response.statusCode == 200){
        final parsed = json.decode(response.body).cast<String, dynamic>();    
        return parsed['doctor_datos'].map<Doctores>((json) => Doctores.fromJson(json)).toList();
      } 
      print('No hay nada chamo');
      return noJodas;     
  }

}