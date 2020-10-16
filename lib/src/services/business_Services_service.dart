import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:http/http.dart' as http;

class BusinessServices with ChangeNotifier {
  BusinessServices() {
    //this.getBusinessServices(ruc);
  }

  Future<List<dynamic>> getBusinessServices(String ruc) async {
    List<NegocioDato> servicioNegocio = new List();
    final url =
        "http://54.197.83.249/PHP_REST_API/api/get/get_business_data_by_ruc.php?business_ruc=$ruc";
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final businessService = servicesBusinessFromJson(resp.body);
      servicioNegocio.addAll(businessService.negocioDatos);
      notifyListeners();
    } else {
      throw Exception('Failed');
    }
    return servicioNegocio;
  }
}
