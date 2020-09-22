import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/apointments_model.dart';
// import 'package:muro_dentcloud/src/services/conf.dart';

class EventosCtrl {
  // String _url = '54.197.83.249';
  // String _apiKey = 'email_doctor=hvargas@utm.ec';
  Future<List<Evento>> eventosPorCorreo() async {
    String emailDoctor = "hvargas@utm.ec";
    String url ='http://54.197.83.249/PHP_REST_API/api/get/get_accepted_appointmen_by_doctor.php?email_doctor=$emailDoctor';

    final resp = await http.get(url);
    print(resp);
    List<dynamic> items = new List();
    items.add(resp.body);
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    final eventos = new Eventos.fromJsonList(decodedData['cita_acceptada']);
    print(eventos.items[0].paciente);
    return eventos.items;
  }
}
