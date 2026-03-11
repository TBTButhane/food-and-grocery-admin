import 'package:get/get.dart';
import 'package:shop4you_admin/models/restaurants_model.dart';
import 'package:shop4you_admin/screens/add_product_screen.dart';
import 'package:shop4you_admin/screens/orders_screen.dart';

import 'package:shop4you_admin/screens/products_screen.dart';
import 'package:shop4you_admin/screens/restaurant_Screen.dart';

import '../screens/add_restaurant_screen.dart';
import '../screens/home_screen.dart';

class RouteHelper {
  static const String initial = "/";
  static const String restaurants = "/restaurants";
  static const String addRestaurants = "/addRestaurants";
  static const String products = "/products";
  static const String addProducts = "/Addproducts";
  static const String orders = "/orders";
  static const String totalRevenue = "/totalRevenue";

  //call routes
  static String getIntial() => initial;
  static String getrestaurants() => restaurants;
  static String getaddRestaurants() => addRestaurants;
  static String getproducts() => products;
  static String getaddProducts() => addProducts;
  static String getorders() => orders;
  static String gettotalRevenue() => totalRevenue;

  //List of get pages

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: restaurants,
        page: () => RestaurantScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: products,
        page: () => const ProductScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: addProducts,
        page: () => AddProductScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: addRestaurants,
        arguments: RestaurantsModel,
        page: () => AddRestaurantScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: orders,
        page: () => const OrdersScreen(),
        transition: Transition.fadeIn),
  ];
}
