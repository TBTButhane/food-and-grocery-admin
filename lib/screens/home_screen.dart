// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/home_screen_controller.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';
import '../routes/routes.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/tile_card.dart';
import '../controllers/order_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getTotalRevenue();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Shop4You Admin",
          style: TextStyle(
              fontSize: Dimensions.font26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GetBuilder<HomeScreenController>(builder: (controller) {
        return GetBuilder<OrderController>(
          builder: (orderController) {
            return
                Column(
              children: [
                Row(
                  children: List.generate(
                      2,
                      (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    Get.toNamed(RouteHelper.getrestaurants());

                                  } else {
                                    print("product screen");
                                    Get.toNamed(RouteHelper.getproducts());

                                  }
                                },
                                child: TileCard(
                                    color: index == 0
                                        ? Colors.green
                                        : Colors.white,
                                    hight: Dimensions.height45+Dimensions.height45,
                                    width: double.maxFinite,
                                    widget: BigText(
                                      text: index == 0
                                          ? "All Restaurant"
                                          : "All Products",
                                      fontColor: index == 0
                                          ? Colors.white
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font26,
                                    )),
                              ),
                            ),
                          )),
                ),
                Row(
                  children: List.generate(
                      2,
                      (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    Get.toNamed(RouteHelper.getorders());
                                  }
                                },
                                child: TileCard(
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.green,
                                    hight: Dimensions.height45+Dimensions.height45,
                                    width: double.maxFinite,
                                    widget: BigText(
                                      text: index == 0
                                          ? "Orders"
                                          : orderController.isLoading
                                              ? "Loading...":orderController.orderModelList.isEmpty?"Total: R ${orderController.totalrevenue}"
                                              : "Total: R ${orderController.totalrevenue}",
                                      fontColor: index == 0
                                          ? Colors.green
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font26,
                                    )),
                              ),
                            ),
                          )),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
