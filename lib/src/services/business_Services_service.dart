import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/business_model.dart';

class BusinessServices {
  Future<List<NegocioData>> getBusinessServices(String ruc) async {
    // List<NegocioDato> servicioNegocio = new List();
    final url =
        "http://54.197.83.249/PHP_REST_API/api/get/get_business_data_by_ruc.php?business_ruc=$ruc";
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      print(decodedData['negocio_datos']);
      final businessService = new Business.fromJsonList(decodedData['negocio_datos']);
      // servicioNegocio.addAll(businessService.negocioDatos);
      return businessService.items;
    } else {
      throw Exception('Failed');
    }
  }
}
