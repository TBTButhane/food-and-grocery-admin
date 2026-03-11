import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you_admin/controllers/order_controller.dart';
import 'package:shop4you_admin/models/orderModel.dart';
import 'package:shop4you_admin/screens/order_details_screen.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  // late bool _isLoggedIn;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    if (Get.find<OrderController>().orderModelList.isEmpty) {
      Get.find<OrderController>().getOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Orders"),
          centerTitle: true,
        ),
        body: GetBuilder<OrderController>(builder: (orderController) {
          return Column(
            children: [
              Container(
                width: Dimensions.screenWidth,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.green,
                  indicatorWeight: 3,
                  labelColor: Colors.green,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  tabs: [
                    Tab(
                      text: "Current orders",
                    ),
                    Tab(
                      text: "Completed Orders",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  SizedBox(
                    child: orderController.orderModelList.isEmpty?Center(child: BigText(text: "You have no pending orders",fontSize: Dimensions.font26),) : ListView.builder(
                        shrinkWrap: true,
                        itemCount: 
                            orderController.orderModelList.length,
                        itemBuilder: (_, index) {
                          return customOrdesTile(
                              "Order ${orderController.orderModelList[index].id}",
                              orderController.orderModelList[index]);
                        }),
                  ),
                  SizedBox(
                    child: orderController.compledOrderModelList.isEmpty
                        ? Center(child: BigText(text: "You have no completed orders",fontSize: Dimensions.font26),)
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                orderController.compledOrderModelList.length,
                            itemBuilder: (_, index) {
                              return customOrdesTile(
                                  "Order ${orderController.compledOrderModelList[index].id}",
                                  orderController.compledOrderModelList[index]);
                            }),
                  )
                ]),
              ),
            ],
          );
        }));
  }

  Widget customOrdesTile(String title, OrderModel order) {
    return Column(
      children: [
        Container(
          height: Dimensions.height45 * 2,
          width: Dimensions.screenWidth,
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BigText(
                  text: title,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 23,
                ),
                Expanded(
                  child: SizedBox(
                    width: Dimensions.screenWidth,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(() => OrderDetailsScreen(
                          index: int.tryParse(order.id), order: order));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height15,
        )
      ],
    );
  }
}
