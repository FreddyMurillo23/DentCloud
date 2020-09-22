import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/services/conf.dart';

String _url = '54.197.83.249';

class EventosCtrl{
  static Future<List<Evento>> eventosPorCorreo() async{
    final url = Uri.http(_url, 'PHP_REST_API/api/get/get_accepted_appointmen_by_doctor.php?email_doctor=hvargas@utm.ec');
    
    final resp = await http.get(url);
     
    final decodedData = json.decode(resp.body);
    final eventos = new Eventos.fromJsonList(decodedData['cita_acceptada']);
    print(eventos);
    return eventos.items;
  }
}