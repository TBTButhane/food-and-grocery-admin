
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/home_screen_controller.dart';
import 'package:shop4you_admin/controllers/notification_controller.dart';
import 'package:shop4you_admin/controllers/order_controller.dart';
import 'package:shop4you_admin/controllers/product_controller.dart';
import 'package:shop4you_admin/controllers/restaurants_controller.dart';
import 'package:shop4you_admin/util/products_repo.dart';
import 'package:shop4you_admin/util/restaurants_repo.dart';
import 'package:shop4you_admin/util/order_repo.dart';

Future<void> init() async {
  //controllers
  Get.lazyPut(() => HomeScreenController());
  Get.lazyPut(() => ProductController(productsRepo: Get.find()));
  Get.lazyPut(() => RestaurantsController(restaurantsRepo: Get.find()));
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  //Repos
  Get.lazyPut(() => OrderRepo());
  Get.lazyPut(() => RestaurantsRepo());
  Get.lazyPut(() => ProductsRepo());
}
