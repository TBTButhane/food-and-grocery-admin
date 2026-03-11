// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key, this.product}) : super(key: key);

  final product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
         
        //     width: Dimensions.screenWidth,
        //       decoration: BoxDecoration(
        //         color: Colors.grey
        //       ),
        //       child:Padding(
        //         padding: const EdgeInsets.only(left: 10,
        //     right: 10,),
        //         child: BigText(
        //                   text: "product.restaurantsModel.name",
        //                   fontColor: Colors.white,
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //       ),
        //     ),
        Padding(
          padding: const EdgeInsets.only(left: 10,
            right: 10,),
          child: Container(
              height: Dimensions.height45 * 2 + 10,
              // width: Dimensions.width30 * 2,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    height: Dimensions.height45 * 2 + 10,
                    width: Dimensions.width30 * 6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(product.image)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: product.name,
                          fontColor: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        BigText(
                          text: product.desc,
                          fontColor: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10 - 2,
                  ),
                  Container(
                    height: Dimensions.height45 * 2 + 10,
                    width: Dimensions.width30 * 5,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Center(
                      child: BigText(
                        text: "R ${product.price}",
                        fontColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
