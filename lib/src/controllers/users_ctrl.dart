import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;

class UserCtrl{
  static Future<bool> registrarUsuarios(String userEmail, String password, String userDNI, String userName, String userLastName, DateTime birthday, String userCellphone, String sex, String userType, String userProfesion, String userProvince, String userCity) async{
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/post/post_user_data.php?user_email=$userEmail&password=$password&user_dni=$userDNI&user_names=$userName&user_last_names=$userLastName&birthdate=$birthday&cellphone=$userCellphone&sex=$sex&user_type=$userType&doctor_profession=$userProfesion");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

