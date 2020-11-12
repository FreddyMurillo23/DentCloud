import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/follows_model.dart';
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



}
