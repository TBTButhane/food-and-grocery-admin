import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  late String? mToken;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> getPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permision granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Provisional permision granted");
    } else {
      print("permision not granted");
    }
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mToken = token;
      print("Device token:$mToken");
    });
    // saveToken(mToken);
  }

  Future<void> saveToken(String? token) async {
    // FirebaseAuth userId = FirebaseAuth.instance;
    Map<String, dynamic> userToken = {"token": token};
    await FirebaseFirestore.instance
        .collection('users')
        .doc('admin')
        .set(userToken);
  }

  Future<void> initInfo() async {
    var androidInitializer =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //var iosInitilalize = IOSIntializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitializer);
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payLoad) async {
        try {
          if (payLoad != null && payLoad.payload!.isEmpty) {
          } else {}
        } catch (e) {}
      },
      //  onDidReceiveBackgroundNotificationResponse:
      //         (NotificationResponse? payLoad) async {
      //   try {
      //     if (payLoad != null && payLoad.payload!.isEmpty) {
      //     } else {}
      //   } catch (e) {}
      // }
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title,
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('shop4you', 'shop4you',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              playSound: true,
              priority: Priority.high);

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['body']);
    });
  }
}
