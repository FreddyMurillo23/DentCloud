import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/apointments_model.dart';
// import 'package:muro_dentcloud/src/services/conf.dart';

class EventosCtrl {

  Future<List<EventModel>> eventosPorCorreo() async {
    String emailDoctor = "hvargas@utm.ec";
    String url ='http://54.197.83.249/PHP_REST_API/api/get/get_accepted_appointmen_by_doctor.php?email_doctor=$emailDoctor';
    final resp = await http.get(url);
    print(resp);
    List<dynamic> items = new List();
    items.add(resp.body);
    final decodedData = json.decode(resp.body);
    final eventos = new Eventos.fromJsonList(decodedData['cita_acceptada']);

    print(eventos.items[0].fecha.year);
    print(eventos.items[0].fecha.month);
    print(eventos.items[0].fecha.day);
    print(eventos.items[0].fecha.hour);
    print(eventos.items[0].fecha.minute);
    print(eventos.items[0].descripcion);
    
    return eventos.items;
  }

    Future<bool> registrarEventos(String ruc, String email, String user, String name, String description, String date) async {
    String url2 = "http://54.197.83.249/PHP_REST_API/api/post/post_medical_appointment.php?business_ruc=$ruc&user_email_doctor=$email&user_email_patient=$user&business_service_name=$name&commentary=$description&date_time=$date";
    final resp = await http.get(url2); 
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    } 
  }
}
