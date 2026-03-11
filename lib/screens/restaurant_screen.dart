// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/restaurants_controller.dart';

import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/custom_loader.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';
import 'package:shop4you_admin/widgets/res_tile.dart';
import 'package:shop4you_admin/widgets/text_form_field.dart';

import '../routes/routes.dart';

class RestaurantScreen extends StatefulWidget {
  RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<RestaurantsController>().getRestaurants();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: BigText(
            text: "Restaurants",
            fontColor: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      body: GetBuilder<RestaurantsController>(builder: (controller) {
        return controller.isLoading? Center(child:CustomLoader()): Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: controller.allRestaurants.isEmpty? Center(child: BigText(text:"No restaurants available", fontSize: Dimensions.font26),):ListView(
            children: List.generate(
                     controller.allRestaurants.length,
                (index) => ResTile(
                      text: controller.allRestaurants[index].name!,
                      imageUrl: controller.allRestaurants[index].logo!,
                      kwidget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                               controller.deleteRes(controller.allRestaurants[index]);
                              },
                              child: Icon(
                                Icons.delete,
                                size: Dimensions.height30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width30 * 2,
                            ),
                            GestureDetector(
                              onTap:(){
                                Get.toNamed(
                                  arguments: controller.allRestaurants[index],
                                  RouteHelper.getaddRestaurants());
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: Dimensions.height30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                          ]),
                    )),
          ),
        );
      }),
      floatingActionButton: _customFloadingActiontBtn(context),
    );
  }

  Widget? _customFloadingActiontBtn(context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getaddRestaurants());
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Center(
          child: BigText(
            text: "Add Restaurant",
            fontColor: Colors.white,
          ),
        ),
      ),
    );
  }

  customWidget() {
    var controller = Get.find<RestaurantsController>();
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.pickImage();
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                image: controller.imageFile == null
                    ? DecorationImage(
                        image: AssetImage("assets/images/noimage.jpg"))
                    : DecorationImage(image: FileImage(controller.imageFile!))),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          textController: controller.restaurantTitleController,
        )
      ],
    );
  }
}
