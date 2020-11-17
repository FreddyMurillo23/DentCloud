import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/negocios_model.dart';

class NegociosCtrl{
  static Future<List<NegociosSearch>> listarNegocios(String name) async{
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_business_by_like.php?name=$name");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed['negocios'].map<NegociosSearch>((json) => NegociosSearch.fromJson(json)).toList();
    }
    return null;
  }
}