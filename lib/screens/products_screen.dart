// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/product_controller.dart';
import 'package:shop4you_admin/controllers/restaurants_controller.dart';
import 'package:shop4you_admin/widgets/custom_loader.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';
import '../routes/routes.dart';

import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/product_tile.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ProductController>().getAllProducts();
    Get.find<RestaurantsController>().getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: BigText(
            text: "Products",
            fontColor: Colors.white,
            fontSize: Dimensions.font26,
            fontWeight: FontWeight.bold,
          )),
      body: GetBuilder<ProductController>(builder: (controller) {
        // var sortedList = controller.allProducts.sort((a,b)=>b.restaurantsModel!.name!.compareTo(a.restaurantsModel!.name!));
        return controller.isAllProductLoading
            ? Center(
                child: CustomLoader(),
              )
            : controller.allProducts.isEmpty
                ? Center(
                    child: BigText(
                        text: "No products available",
                        fontSize: Dimensions.font26),
                  )
                : ListView(
                    children: List.generate(
                        controller.allProducts.length,
                        (index) => GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    arguments: controller.allProducts[index],
                                    RouteHelper.getaddProducts());
                              },
                              child: ProductTile(
                                  product: controller.allProducts[index]),
                            )),
                  );
      }),
      floatingActionButton: _customFloadingActiontBtn(context),
    );
  }

  Widget? _customFloadingActiontBtn(context) {
    return GestureDetector(
      onTap: () {
        //TODO: do proper routing
        Get.toNamed(RouteHelper.getaddProducts());
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Center(
          child: BigText(
            text: "Add Product",
            fontColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
