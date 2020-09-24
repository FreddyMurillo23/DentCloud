import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/models/login_model.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';

class DataProvider {
  // String _apiKey = '';
  String _url = '54.197.83.249';
  // String _language = 'es-ES';
  //! PROVIDER DE TODAS LAS PRUBLICACIONES
  //? Future que espera la respuesta del http para seguir con la ejecucion.
  Future<List<Publicacion>> getPublicaciones() async {
    final url = Uri.http(_url, 'PHP_REST_API/api/get/get_publications.php');
    //? Solicitud http.get + url
    final resp = await http.get(url);
    //? decodificacion de la data json.decode
    final decodedData = json.decode(resp.body);
    final publicaciones =
        new Publicaciones.fromJsonList(decodedData['publicaciones']);
    // print(publicaciones.items[0].usuario);

    return publicaciones.items;
  }

  //!PROVIDER DE DATOS PARA LA AGENDA
  Future<List<EventModel>> eventosPorCorreo(emailDoctor) async {
    // String emailDoctor = "hvargas@utm.ec";
    String url =
        'http://54.197.83.249/PHP_REST_API/api/get/get_accepted_appointmen_by_doctor.php?email_doctor=$emailDoctor';

    final resp = await http.get(url);
    print(resp);
    List<dynamic> items = new List();
    items.add(resp.body);
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    final eventos = new Eventos.fromJsonList(decodedData['cita_acceptada']);
    print(eventos.items[0].fecha.year);
    print(eventos.items[0].fecha.month);
    print(eventos.items[0].fecha.day);
    print(eventos.items[0].fecha.hour);
    print(eventos.items[0].fecha.minute);
    print(eventos.items[0].descripcion);
    return eventos.items;
  }

  Future<String> loginUsuario(email, password) async {
    String email = 'bb@utm.ec';
    String password = '123';
    String url =
        'http://54.197.83.249/PHP_REST_API/api/get/get_select_by_login.php?user_email=$email&password=$password';
    final resp = await http.get(url);
    print(resp);
    List<dynamic> items = new List();
    items.add(resp.body);
    Map <String, dynamic> decodedData = json.decode(resp.body);
    // items.add(decodedData);
    print(decodedData['message']);
    return decodedData['message'];
  }

  Future<bool> registrarEventos(String ruc, String email, String user,
      String name, String description, String date) async {
    String url2 =
        "http://54.197.83.249/PHP_REST_API/api/post/post_medical_appointment.php?business_ruc=$ruc&user_email_doctor=$email&user_email_patient=$user&business_service_name=$name&commentary=$description&date_time=$date";
    final resp = await http.get(url2);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
