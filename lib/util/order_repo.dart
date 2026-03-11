import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop4you_admin/models/orderModel.dart';
import 'package:shop4you_admin/util/const.dart';

class OrderRepo {
  //Get All orders
  Future<List<OrderModel>> getOrders(
      // DocumentSnapshot? lastOrder
      ) async {
    return await fFireStore.collection('orders').orderBy("createdAt").get().then((value) {
      // lastOrder = value.docs.last;
      return value.docs.map((e) => OrderModel.fromJson(e.data())).toList().reversed.toList();
    });
    // if (lastOrder == null) {
    //   return await fFireStore
    //       .collection('orders')
    //       .orderBy('createdAt')
    //       .get()
    //       .then((value) {
    //     lastOrder = value.docs.last;
    //     return value.docs.map((e) => OrderModel.fromJson(e.data())).toList().reversed.toList();
    //     // .reversed
    //     // .toList();
    //   });
    // } else {
    //   return await fFireStore.collection('orders').orderBy("createdAt").get().then((value) {
    //     lastOrder = value.docs.last;
    //     return value.docs.map((e) => OrderModel.fromJson(e.data())).toList().reversed.toList();
    //   });
    // }
  }

  //Update Order

  Future<void> updateOrder(OrderModel order) async {
    await fFireStore
        .collection('orders')
        .doc('order ${order.id}')
        .update(order.toJson())
        .whenComplete(() {
      fFireStore
          .collection('users')
          .doc(order.userId)
          .collection('orders')
          .doc('order ${order.id}')
          .update(order.toJson());
    });
  }

  // Future<OrderModel> getOrder(OrderModel orderModel) async {
  //   var getorder = fFireStore.collection('orders').doc(orderModel.id).get();
  //   var order = jsonEncode(jsonDecode(OrderModel.fromJson(getorder)));
  //   return order;
  // }
}
