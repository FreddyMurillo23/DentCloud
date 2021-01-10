import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((value) {
      print(value);
    });

    _firebaseMessaging.configure(
      onMessage: (message) {
        print("On Message");
      },

      onLaunch: (message) {
        print("On Launch");
      },

      onResume: (message) {
        print("On Resume");
      },
    );
  }
}