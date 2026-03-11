// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:shop4you_admin/models/orderModel.dart';
import '../util/order_repo.dart';

class OrderController extends GetxController {
  final OrderRepo orderRepo;
  OrderController({
    required this.orderRepo,
  });
  List<OrderModel> _orderModelList = [];
  List<OrderModel> get orderModelList => _orderModelList;
  List<OrderModel> _compledOrderModelList = [];
  List<OrderModel> get compledOrderModelList => _compledOrderModelList;
  double _totalRevenue = 0;
  double get totalrevenue => _totalRevenue;
  DocumentSnapshot? lastOrder;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //Get list of orders

  Future<void> getOrders() async {
    _isLoading= true;
    _orderModelList = [];
    _compledOrderModelList = [];
    // List<OrderModel> orderList = await orderRepo.getOrders(lastOrder);
    List<OrderModel> orderList = await orderRepo.getOrders();

    update();
    if(orderList.isNotEmpty){
      for (var element in orderList) {
        if (element.orderStatus == 'pending' ||
            element.orderStatus == 'accepted' ||
            element.orderStatus == 'processing' ||
            element.orderStatus == 'handover' ||
            element.orderStatus == 'picked_up' ||
            element.orderStatus == 'confirmed' ||
            element.orderStatus == 'processing' ) {
          _orderModelList.add(element);
        } else {
          _compledOrderModelList.add(element);
        }
      }
    }else{
      _orderModelList = [];
      _compledOrderModelList = [];
    }

    _isLoading=false;
    update();
  }

  //update order
  Future<void> updateOrder(OrderModel order) async {
    await orderRepo.updateOrder(order);
    getOrders();
  }

  //total revenue of orders
  Future<void> getTotalRevenue() async {
    _isLoading = true;
    _totalRevenue = 0;
    await getOrders();
    update();
    if(_orderModelList.isEmpty){
      _totalRevenue=0;
    }else{
      for (var element in _orderModelList) {
        _totalRevenue = _totalRevenue + element.orderAmount!;
      }
    }

    _isLoading = false;
    update();
  }
  //get a specific order

  // Future<void> getOrder(OrderModel orderModel) async {
  //   var order = await orderRepo.getOrder(OrderModel);
  // }

  //edit order

  //delete order
}
