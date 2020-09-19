import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/publications_model.dart';

class PublicacionesProvider {
  String _apiKey = '';
  String _url = '54.197.83.249';
  String _language = 'es-ES';

  Future<List<Publicacion>> getPublicaciones() async {
    final url = Uri.http(_url, 'PHP_REST_API/api/get/get_publications.php');

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final publicaciones = new Publicaciones.fromJsonList(decodedData['publicaciones']);
    print(publicaciones.items[0].usuario);

    return publicaciones.items;
  }
} 
 