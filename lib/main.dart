import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/product_controller.dart';
import 'package:shop4you_admin/controllers/restaurants_controller.dart';
import 'package:shop4you_admin/dependancy/init.dart' as dep;
import 'controllers/notification_controller.dart';
import 'controllers/order_controller.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<NotificationController>().getPermissions();
    Get.find<NotificationController>().getToken();
    Get.find<NotificationController>().initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return GetBuilder<RestaurantsController>(builder: (resController) {
        return GetBuilder<OrderController>(builder: (orderControlller) {
          return GetMaterialApp(
            title: 'Shop4You Admin',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            initialRoute: RouteHelper.getIntial(),

            getPages: RouteHelper.routes,
          );
        });
      });
    });
  }
}
