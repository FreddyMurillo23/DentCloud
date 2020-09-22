import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/services/conf.dart';

String _url = '54.197.83.249';
List<EventModel> eventosCtrl = List<EventModel>(); 

class EventosProvider{

static Future<List<EventModel>> getEventos(String correo) async {
    final response = await http.get(GlobalVars.apiUrl+"get/get_accepted_appointmen_by_doctor.php?email_doctor="+correo);
    print(response.body);
    final decoteData = json.decode(response.body);
    
  }

}
