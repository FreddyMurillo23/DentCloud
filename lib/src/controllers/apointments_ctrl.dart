import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/services/conf.dart';

class EventosCtrl{
  static Future<List<EventModel>> eventosPorCorreo() async{
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_accepted_appointmen_by_doctor.php?email_doctor=hvargas@utm.ec");
    print(response.body);
    final parsed = json.decode(response.body).cast<String, dynamic>();
    return parsed["CITA_ACEPTADA"].map<EventModel>((json) => EventModel.fromJson(json)).toList();
  }
}