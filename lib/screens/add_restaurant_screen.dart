// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/restaurants_controller.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/custom_loader.dart';
import 'package:shop4you_admin/widgets/custome_snackbar.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';
import 'package:shop4you_admin/widgets/text_form_field.dart';

class AddRestaurantScreen extends StatelessWidget {
  final restaurantParam = Get.arguments;
  AddRestaurantScreen({Key? key}) : super(key: key);

  final TextEditingController resNameController = TextEditingController();

  void uploadRestaurant() {
    var controller = Get.find<RestaurantsController>();

    if (resNameController.text.isNotEmpty) {
      if (controller.imageFile != null) {
        controller
            .addRestaurant(resNameController.text, controller.imageFile!)
            .then((value) {
          print("Successfully Created Restaurant");
          controller.restaurantTitleController.clear();
          resNameController.clear();
          controller.imageFile = null;
          controller.allRestaurants.clear();
          Get.find<RestaurantsController>().getRestaurants();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: BigText(
          text: "Add Restaurant",
          fontColor: Colors.white,
          fontSize: 20,
        ),
      ),
      body: GetBuilder<RestaurantsController>(builder: (resController) {
        return restaurantParam != null
            ? resController.isLoading
                ? Center(
                    child: CustomLoader(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 150,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                image: resController.imageFile == null
                                    ? DecorationImage(
                                        fit: BoxFit.contain,
                                        image:
                                            NetworkImage(restaurantParam.logo))
                                    : DecorationImage(
                                        fit: BoxFit.contain,
                                        image: FileImage(
                                            resController.imageFile!)),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: Stack(
                              children: [
                                Positioned.fromRect(
                                    rect: Rect.fromCircle(
                                        center: Offset(
                                            MediaQuery.of(context).size.width /
                                                2.1,
                                            140),
                                        radius: 200),
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 8,
                                            left: 8,
                                            right: 8,
                                            top: 3),
                                        color: Colors.green,
                                        child: GestureDetector(
                                          onTap: () {
                                            resController.pickImage();
                                          },
                                          child: BigText(
                                            text: "Change Image",
                                            fontColor: Colors.white,
                                            fontSize: Dimensions.font16 + 3,
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          textController: resNameController,
                          labelName: restaurantParam.name,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              resController.restaurantTitleController.text =
                                  resNameController.text.trim();
                              if (resController.restaurantTitleController.text
                                      .isNotEmpty ||
                                  resController.imageFile != null) {
                                print("updating res");
                                restaurantParam.name = resController
                                    .restaurantTitleController.text
                                    .trim();
                                resController.updateRes(restaurantParam);
                                resNameController.clear();
                                resController.restaurantTitleController.clear();
                                resController.imageFile = null;
                                showCustomSnackbar(
                                    "Restaurant update successfully",
                                    title: "Restaurant updated",
                                    isError: false);
                              } else {
                                showCustomSnackbar("Nothing to Change",
                                    title: "No changes");
                              }
                            },
                            child: Container(
                                height: 70,
                                width: double.maxFinite,
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                    child: BigText(
                                  text: "Update Restaurant",
                                  fontColor: Colors.white,
                                  fontSize: Dimensions.font26,
                                ))),
                          ),
                        ),
                      ],
                    ),
                  )
            : Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: Dimensions.height45 * 4 == 180
                            ? Dimensions.height45 * 4
                            : 150,
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                            image: resController.imageFile == null
                                ? DecorationImage(
                                    fit: BoxFit.contain,
                                    image:
                                        AssetImage("assets/images/noimage.jpg"))
                                : DecorationImage(
                                    fit: BoxFit.contain,
                                    repeat: ImageRepeat.noRepeat,
                                    image: FileImage(resController.imageFile!)),
                            shape: BoxShape.circle,
                            color: Colors.white),
                        child: Stack(
                          children: [
                            Positioned.fromRect(
                                rect: Rect.fromCircle(
                                    center: Offset(
                                        MediaQuery.of(context).size.width / 2.1,
                                        140),
                                    radius: 200),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 8, left: 8, right: 8, top: 3),
                                    color: Colors.green,
                                    child: GestureDetector(
                                      onTap: () {
                                        resController.pickImage();
                                      },
                                      child: BigText(
                                        text: "Add Image",
                                        fontColor: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      textController: resNameController,
                      labelName: "Restaurant Name",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (resNameController.text.isEmpty ||
                              resController.imageFile == null) {
                            showCustomSnackbar(
                                "Restaurant Name or Image can't be empty",
                                title: "Restaurant Name or Image empty");
                          } else {
                            uploadRestaurant();
                            showCustomSnackbar("Restaurant successfully added",
                                title: "Adding restaurant successful", isError: false);
                          }
                        },
                        child: Container(
                            height: 70,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: BigText(
                              text: "Save",
                              fontColor: Colors.white,
                              fontSize: Dimensions.font26,
                            ))),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
