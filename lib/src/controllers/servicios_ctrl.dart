import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/services_model.dart';

class ServiciosCtrl{
  static Future<List<Servicios>> listarServicios(String dni) async{
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_service_business_ruc.php?business_ruc=$dni");
    if (response.statusCode == 200) {
      print(response.body);
      final parsed = json.decode(response.body).cast<String, dynamic>();
      print("objectSi");
      return parsed['servicios'].map<Servicios>((json) => Servicios.fromJson(json)).toList();
    }
    print("objectNo");
    return null;
  }
}