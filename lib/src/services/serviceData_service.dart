import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:http/http.dart' as http;

class HttpServiceData {
  Future<List<dynamic>> getServices(String id) async {
    List<Servicio> servicio = new List();
    final url =
        "http://54.197.83.249/PHP_REST_API/api/get/get_services_frequent_questions.php?id_service=$id";
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final businessService = businessServiceFromJson(resp.body);
      servicio.addAll(businessService.servicios);
      print(servicio);
      return servicio;
    } else {
      throw Exception('Failed');
    }
  }
}
