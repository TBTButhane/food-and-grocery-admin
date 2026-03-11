// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/product_controller.dart';
import 'package:shop4you_admin/controllers/restaurants_controller.dart';
import 'package:shop4you_admin/models/addon.dart';
import 'package:shop4you_admin/models/restaurants_model.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/text_form_field.dart';

import '../widgets/custom_loader.dart';
import '../widgets/custome_snackbar.dart';
import '../widgets/dimentions.dart';

class AddProductScreen extends StatelessWidget {
  final productParam = Get.arguments;
  AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: productParam != null
          ? AppBar(
              backgroundColor: Colors.green,
              title: BigText(
                text: productParam.name,
                fontColor: Colors.white,
                fontSize: 20,
              ),
              actions: [
                IconButton(onPressed: () {
                  // print("Deleting product ${productParam.name} with id: ${productParam.id}");
                  Get.find<ProductController>().deleteProduct(productParam);
                  showCustomSnackbar("Product Deleted successfully", title: "Product Deleted", isError:false);
                  Get.back();
                }, icon: Icon(Icons.delete))
              ],
            )
          : AppBar(
              backgroundColor: Colors.green,
              title: BigText(
                text: "Add Product",
                fontColor: Colors.white,
                fontSize: 20,
              ),
            ),
      body: GetBuilder<ProductController>(builder: (productController) {
        return GetBuilder<RestaurantsController>(builder: (resController) {
          return productParam != null
              ? productController.isAllProductLoading
                  ? Center(
                      child: CustomLoader(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  productController.proPickImage();
                                },
                                child: Container(
                                  height: 150,
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                            fit:BoxFit.contain,
                                            image: NetworkImage(productParam
                                                .image)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fromRect(
                                          rect: Rect.fromCircle(
                                              center: Offset(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
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
                                              child: BigText(
                                                text: "Change Image",
                                                fontColor: Colors.white,
                                                fontSize: Dimensions.font20,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              textController:
                                  productController.productTitleController,
                              labelName: productParam.name,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textController:
                                  productController.productDescController,
                              labelName: productParam.desc,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textController:
                                  productController.productPriceController,
                              labelName: "R ${productParam.price}",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButton<RestaurantsModel>(
                              alignment: Alignment.centerLeft,
                              value: resController.updatedSelectedRestaurantValue,
                              hint: BigText(text: "Select Restaurant"),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: resController.allRestaurants
                                  .map((item) =>
                                      DropdownMenuItem<RestaurantsModel>(
                                          value: item,
                                          child: Row(
                                            children: [
                                              Image(
                                                height: 50,
                                                width:50,
                                                image: NetworkImage(item.logo!),
                                                fit: BoxFit.cover,
                                              ),
                                              Text(item.name!),
                                            ],
                                          )))
                                  .toList(),
                              onChanged: ((result) {
                                resController.updatedSelectedRestaurantValue = result!;
                                productController.dropDownValue =resController.updatedSelectedRestaurantValue;
                                resController.update();
                              }),
                            ),
                            Row(
                              children: [
                                Text("Does this product have addons"),
                                SizedBox(
                                  width: 25,
                                ),
                                Switch(
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Color.fromRGBO(76, 175, 80, 1),
                                  onChanged: (bool value) {
                                    productController.hasAddons = value;
                                    print(productController.hasAddons);
                                    productController.update();
                                  },
                                  value: productController.hasAddons,
                                ),
                              ],
                            ),
                            productController.hasAddons
                                ? SizedBox(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              productController
                                                  .addonPickImage();
                                            },
                                            child: Container(
                                              height: 150,
                                              margin: EdgeInsets.only(top: 15),
                                              decoration: BoxDecoration(
                                                image: productController
                                                            .addonImageFile ==
                                                        null
                                                    ? DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: AssetImage(
                                                            "assets/images/noimage.jpg"))
                                                    : DecorationImage(
                                                        image: FileImage(
                                                            productController
                                                                .addonImageFile!)),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned.fromRect(
                                                      rect: Rect.fromCircle(
                                                          center: Offset(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.1,
                                                              140),
                                                          radius: 200),
                                                      child: Center(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 8,
                                                                  left: 8,
                                                                  right: 8,
                                                                  top: 3),
                                                          color: Colors.green,
                                                          child: BigText(
                                                            text: "Add Image",
                                                            fontColor:
                                                                Colors.white,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
                                          textController: productController
                                              .addonTitleController,
                                          labelName: "Addon name",
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
                                          textController: productController
                                              .addonpriceController,
                                          labelName: "Price",
                                        ),
                                      ],
                                    ),
                                  )
                                : Text("has no addons"),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  productController.updateProduct(productParam);
                                  showCustomSnackbar("Product updated successfully", title: "Product Updated", isError:false);
                                },
                                child: Container(
                                    height: 70,
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Center(
                                        child: BigText(
                                      text: "Update Product",
                                      fontColor: Colors.white,
                                      fontSize: 20,
                                    ))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              productController.proPickImage();
                            },
                            child: Container(
                              height: 150,
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                image:
                                    productController.productImageFile == null
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                "assets/images/noimage.jpg"))
                                        : DecorationImage(
                                            image: FileImage(productController
                                                .productImageFile!)),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fromRect(
                                      rect: Rect.fromCircle(
                                          center: Offset(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
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
                                          child: BigText(
                                            text: "Add Image",
                                            fontColor: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          textController:
                              productController.productTitleController,
                          labelName: "Product Name",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          textController:
                              productController.productDescController,
                          labelName: "Product desc",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          textController:
                              productController.productPriceController,
                          labelName: "Price",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<RestaurantsModel>(
                          alignment: Alignment.centerLeft,
                          value: resController.selectedRestaurantValue,
                          onChanged: ((RestaurantsModel? restaurant) {
                            resController.selectedRestaurantValue = restaurant!;
                            productController.dropDownValue =resController.selectedRestaurantValue;
                            resController.update();
                          }),
                          hint: BigText(text: "Select Restaurant"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: resController.allRestaurants
                              .map((item) => DropdownMenuItem<RestaurantsModel>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      // Image(
                                      //   height: 50,
                                      //   width:50,
                                      //   image: NetworkImage(item.logo!),
                                      //   fit: BoxFit.cover,
                                      // ),
                                      Text(item.name!),
                                    ],
                                  )))
                              .toList(),

                        ),
                        Row(
                          children: [
                            Text("Does this product have addons"),
                            SizedBox(
                              width: 25,
                            ),
                            Switch(
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Color.fromRGBO(76, 175, 80, 1),
                              onChanged: (bool value) {
                                productController.hasAddons = value;
                                print(productController.hasAddons);
                                productController.update();
                              },
                              value: productController.hasAddons,
                            ),
                          ],
                        ),
                        productController.hasAddons
                            ? SizedBox(
                                child: Column(
                                  children: [

                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          productController.addonPickImage();
                                        },
                                        child: Container(
                                          height: 150,
                                          margin: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                            image: productController
                                                        .addonImageFile ==
                                                    null
                                                ? DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: AssetImage(
                                                        "assets/images/noimage.jpg"))
                                                : DecorationImage(
                                                    image: FileImage(
                                                        productController
                                                            .addonImageFile!)),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned.fromRect(
                                                  rect: Rect.fromCircle(
                                                      center: Offset(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
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
                                                      child: BigText(
                                                        text: "Add Image",
                                                        fontColor: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField(
                                      textController: productController
                                          .addonTitleController,
                                      labelName: "Addon name",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField(
                                      textController: productController
                                          .addonpriceController,
                                      labelName: "Price",
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          AddonModel addon = AddonModel(
                                            image: productController
                                                .addonImageFile!.path,
                                            name: productController
                                                .addonTitleController.text,
                                            price: double.parse(productController
                                                .addonpriceController.text),
                                          );
                                          productController.addAddonToTempList(addon);
                                          showCustomSnackbar("Addon added successfully", title: "Addon Added", isError:false);
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
                                                  text: "Add Addon",
                                                  fontColor: Colors.white,
                                                  fontSize: 20,
                                                ))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // productController.tempAllAddons.isEmpty? SizedBox():
                                    // ExpansionTile(
                                    //   title: Text("List of Addons"),
                                    //   children: List.generate(productController.tempAllAddons.length, (index) => SizedBox(
                                    //     child: ListTile(
                                    //       leading: CircleAvatar(
                                    //         radius: 25,
                                    //         // child: Image.file(File(productController.tempAllAddons[index].image!)),
                                    //         backgroundImage: FileImage(File(productController.tempAllAddons[index].image!)),
                                    //       ),
                                    //       title: Text(productController.tempAllAddons[index].name!),
                                    //     ),
                                    //   )),
                                    // ),
                                  ],
                                ),
                              )
                            : Text("has no addons"),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              productController.addProduct();
                              showCustomSnackbar("Product added successfully", title: "Product Added", isError:false);
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
                                  text: "Save Product",
                                  fontColor: Colors.white,
                                  fontSize: 20,
                                ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
        });
      }),
    );
  }
}
