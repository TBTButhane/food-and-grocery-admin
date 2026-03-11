import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/models/orderModel.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../controllers/order_controller.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int? index;
  final OrderModel order;
  OrderDetailsScreen({Key? key, this.index, required this.order})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List orderStatus = [
    "pending",
    "confirmed",
    "canceled",
    "failed",
    "delivered",
    "handover",
    "picked up",
    "processing",
    "accepted",
  ];

  PageController pageController = PageController(viewportFraction: 0.8);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // String jsonData = jsonEncode(order);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: BigText(
          text: "order: ${widget.index} details",
          fontColor: Colors.white,
          fontSize: Dimensions.font20,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        productImageCarosel(),
        orderDetailsContainer(context)
        // orderDetailsContainer(jsonData)
      ])),
    );
  }

  //Order Product Carocel
  Widget productImageCarosel() {
    return Container(
      height: Dimensions.screenHeight / 2.5,
      width: Dimensions.screenWidth,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Slide section
          // GetBuilder<PopularProductController>(builder: (controller) {
          //   return
          Container(
            height: (Dimensions.height45 +
                    Dimensions.height45 +
                    Dimensions.height30) *
                2,
            // color: Colors.red,
            child: PageView.builder(
                itemCount: widget.order.placeOrderDetails!.cart!.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return  InkWell(

                      child: _buildPageItem(index, widget.order.placeOrderDetails!.cart!)
                      );
                }),
          ),
          //Dots
          DotsIndicator(
            dotsCount: widget.order.placeOrderDetails!.cart!.isEmpty
                ? 1
                : widget.order.placeOrderDetails!.cart!.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: Colors.yellow.shade600,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(
    int index,
    getproductsList,
  ) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
        transform: matrix,
        child:
            // GetBuilder<PopularProductController>(
            //   builder: (controller) {
            //     return
            Stack(
          children: [
            Container(
              height: (Dimensions.height45 + Dimensions.height45) * 3,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget
                        .order.placeOrderDetails!.cart![index].image
                        .toString())),
                borderRadius: BorderRadius.circular(30),
              ),

            ),

          ],
        )

        );
  }

  //Order Details container
  Widget orderDetailsContainer(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController)=>Container(
      // height: Dimensions.screenHeight / 1.5,
      width: Dimensions.screenWidth,
      child: Padding(
        padding: EdgeInsets.only(
            top: Dimensions.height10,
            left: Dimensions.width10,
            right: Dimensions.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(child: Text(jsonData))
            BigText(
                text: widget.order.placeOrderDetails!.cart!.length <= 1
                    ? 'Ordered Item:'
                    : 'Ordered Items:'),
            SizedBox(
              height: Dimensions.height10,
            ),
            Row(
              children: List.generate(
                  widget.order.placeOrderDetails!.cart!.length,
                  (index) => SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            widget.order.placeOrderDetails!.cart![index].name
                                    .toString() +
                                ", ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ),
                      )),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            BigText(
                text: widget.order.placeOrderDetails!.cart!.length <= 1
                    ? 'From Restaurant:'
                    : 'From Restaurants:'),
            SizedBox(
              height: Dimensions.height10,
            ),
            Column(
              children: List.generate(
                  widget.order.placeOrderDetails!.cart!.length,
                  (index) => SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(
                            children: [
                              Text(
                                widget.order.placeOrderDetails!.cart![index]
                                        .name
                                        .toString() +
                                    " from ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Text(
                                widget.order.placeOrderDetails!.cart![index]
                                    .product!.restaurantsModel!.name
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            widget.order.deliveryAddress != null
                ? const BigText(text: 'Delivery Details:')
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? SizedBox(
                    height: Dimensions.height10,
                  )
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? BigText(
                    text:
                        "Delivery Address: ${widget.order.deliveryAddress!.address}",
                  )
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? SizedBox(
                    height: Dimensions.height10,
                  )
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? BigText(
                    text:
                        "Contact Person: ${widget.order.deliveryAddress!.contactPerson}",
                  )
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? SizedBox(
                    height: Dimensions.height10,
                  )
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? BigText(
                    text:
                        "Contact Number: ${widget.order.deliveryAddress!.contactNumber}",
                  )
                : const SizedBox(),
            widget.order.deliveryAddress != null
                ? SizedBox(
                    height: Dimensions.height10,
                  )
                : const SizedBox(),
            const BigText(text: 'Order Status:'),
            SizedBox(
              height: Dimensions.height10 - 8,
            ),
            Row(
              children: [
                BigText(text: widget.order.orderStatus.toString()),
                Expanded(
                  child: SizedBox(
                    width: Dimensions.width20,
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setStatex) {
                              return Dialog(
                                child: Container(
                                  height: Dimensions.height45 * 5,
                                  child: Column(
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: BigText(
                                            text: "Change Order Status"),
                                      )),
                                      Expanded(
                                        child: Container(
                                          height: Dimensions.height45 * 3,
                                          child: DropdownButton<String>(
                                            alignment: Alignment.centerLeft,
                                            value: widget.order.orderStatus,
                                            hint: const BigText(
                                                text: "Order Status"),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: orderStatus
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(item)))
                                                .toList(),
                                            onChanged: ((String? result) {
                                              setStatex(() {
                                                widget.order.orderStatus =
                                                    result;
                                               
                                              });
                                             
                                              setState(() {});
                                            }),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.green)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const BigText(
                                                    text: "cancel",
                                                    fontColor: Colors.white)),
                                            Expanded(
                                              child: SizedBox(
                                                width: Dimensions.screenWidth,
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.green)),
                                                onPressed: () async{
                                              await  orderController
                                                      .updateOrder(
                                                          widget.order);
                                                  Navigator.pop(context);
                                                },
                                                child: const BigText(
                                                    text: "Save",
                                                    fontColor: Colors.white)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          });
                    },
                    child: const Text("Change"))
              ],
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            const BigText(text: 'Payment Method:'),
            SizedBox(
              height: Dimensions.height10,
            ),

            BigText(text: widget.order.paymentStatus.toString()),
            SizedBox(
              height: Dimensions.height10,
            ),
            const BigText(text: 'Total Amount:'),
            SizedBox(
              height: Dimensions.height10,
            ),

            BigText(text: "R ${widget.order.orderAmount}"),
            SizedBox(
              height: Dimensions.height10,
            ),
            widget.order.orderNote == ""
                ? const SizedBox()
                : Column(
                    children: [
                      const BigText(text: 'order Note:'),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      BigText(text: "${widget.order.orderNote}"),
                    ],
                  )
          ],
        ),
      ),
    ));
  }
}
