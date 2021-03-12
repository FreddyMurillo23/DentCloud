import 'dart:async'; 
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class UserCtrl{
  static Future<bool> registrarUsuarios(String userEmail, String password, String userDNI, String userName, String userLastName, DateTime birthday, String userCellphone, String sex, String userType, String userProfesion, String userProvince, String userCity) async{
    String deviceToken='';
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((value) {
      deviceToken = value;
    });
    final response = await http.post("http://54.197.83.249/PHP_REST_API/api/post/post_user_data.php?user_email=$userEmail&password=$password&user_dni=$userDNI&user_names=$userName&user_last_names=$userLastName&birthdate=$birthday&cellphone=$userCellphone&sex=$sex&user_type=$userType&doctor_profession=$userProfesion&province_resident=$userProvince&city_resident=$userCity&device_token=$deviceToken");
    if (response.statusCode == 200) {
      print("si");
      return true;
    } else {
      print("no");
      return false;
    }
  }
}

