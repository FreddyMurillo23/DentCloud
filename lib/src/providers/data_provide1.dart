import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/chat_model.dart';
import 'package:muro_dentcloud/src/models/follows_model.dart';
import 'package:muro_dentcloud/src/models/lista_chat_model.dart';
import 'package:muro_dentcloud/src/models/search_model/business_data_search.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_search.dart';

class DataProvider1{

 Future <List<UserData>> userSearch(String query)
 async {
   String url='http://54.197.83.249/PHP_REST_API/api/get/get_user_by_like.php?user_name=$query';
   final resp = await http.get(url);
   if(resp.statusCode==200)
   {
    final decodedData = json.decode(resp.body);
    final data =  UserDatas.fromJsonList(decodedData['usuarios']);
    // print(decodedData);
    // print(decodedData['usuario']);
    return data.items;
   }
 }

 Future <List<UltimosMensaje>> getListaChat(String emailuser)
  async {
    
    String url='http://54.197.83.249/PHP_REST_API/api/get/get_recent_message.php?user_email=$emailuser';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final listachat = new ChatData.fromJsonList(decodedData['ultimos_mensajes']);
    return listachat.items;
  }


 Future <List<Negocio>> businesSearch(String query)
 async {
   String url='http://54.197.83.249/PHP_REST_API/api/get/get_business_by_like.php?name=$query';
   final resp = await http.get(url);
   if(resp.statusCode==200)
   {
    final decodedData = json.decode(resp.body);
    final data =  BusinesData.fromJsonList(decodedData['negocios']);
    // print(decodedData);
    // print(decodedData['usuario']);
    return data.items;
   }
 }
 
 Future<List<Siguiendo>> followsearch(String emailUser, String query) async {
    String url =
        'http://54.197.83.249/PHP_REST_API/api/get/get_followers_by_like.php?user_email=$emailUser&name=$query';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final decodedData = jsonDecode(resp.body);
      // print(decodedData['siguiendo']);
      final follows = Follow.fromJsonList(decodedData['siguiendo']);
      // print('here');
      // print(follows.items.length);
      return follows.items;
    } else {
      return new List();
    }
  }
  Future <bool> ingresarMensajes(
    String emisor,String receptor,String sala,String mensaje, String fotopath)async
  {
     DateTime now = new DateTime.now();
    var url2 = Uri.parse(
        "http://54.197.83.249/PHP_REST_API/api/post/post_insert_message.php?user_email=$emisor&user_email_emi=$receptor&message_content=$mensaje&message_date=$now&message_type=M&message_url_content");
    var request = http.MultipartRequest('POST', url2);
    if (fotopath != null) {
      var pic = await http.MultipartFile.fromPath("archivo", fotopath);
      request.files.add(pic);
    }
    return true;
  }

   Future<List<ChatSeleccionado>> obtenerChat(
      String sala) async {
    String url =
        'http://54.197.83.249/PHP_REST_API/api/get/get_select_by_chat.php?room_id=$sala';
    final resp = await http.get(url);
    List<dynamic> items = new List();
    items.add(resp.body);
    final decodedData = json.decode(resp.body);
    final mensaje =
        new MensajeriaData.fromJsonList(decodedData['chat_seleccionado']);
    return mensaje.items;
  }



}
