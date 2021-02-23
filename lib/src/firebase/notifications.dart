import 'dart:async';
import 'dart:io';
import 'dart:convert'; 
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  Future<bool> notificationTest() async {
    http.Response response = await http.post(
      "https://fcm.googleapis.com/fcm/send",
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAF3o7hC0:APA91bG9epBrVZLExUuxVV0eIb-C2rRE8HU2-MFuamrjxIgKJrG0sMteUSS1LWNPaTxeNdKriHlgfhTDtKugRSRUaPGNIYbXvY6R3d6mA3BX5mpqAwix7BYmF-3UDZJUTGF6V3b4ahAk',
      },
      body: jsonEncode(<String, dynamic>{
        'to': "cbHnSk--Qw6K4vfGtfXSkV:APA91bE5TU0Z-UXKFK8lzh00TdkTZcGDMLd7ThplWfNCe6H7Zzr9SdBXkyyMX_FXPw0D4BF_FBkQ0_aaPnz8GVJJKOl_64l34hgthqbh_w9onlrIj-BcMUBqs1eVzhR5KjU6sbtmK1QC",
        'notification': {
          'title': 'Testing',
          'body': 'Prueba'     
        },
        },
      ),
    ); 
    if (response.statusCode == 200) {
      print('true');
      return true;
    } else {
      return false;
    } 
  }

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    notificationTest();

    _firebaseMessaging.getToken().then((value) {
      print(value);

    


    });

    _firebaseMessaging.configure(
      onMessage: (message) {
        print("On Message");

        if(Platform.isAndroid) {

        }

       // _mensajesStreamController.sink.add(message);
      },

      onLaunch: (message) {
        print("On Launch");
      },

      onResume: (message) {
        print("On Resume");
      },
    );
  }

  dispose(){
    _mensajesStreamController?.close();
  }
}