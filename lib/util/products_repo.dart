import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop4you_admin/models/product_model.dart';
import 'dart:convert';

class ProductsRepo {
 FirebaseFirestore _fireDB = FirebaseFirestore.instance;

 Future<void>addProduct(ProductModel product)async{
   await _fireDB.collection("products").doc("${product.id}").set(product.toJson());
 }

Future<List<ProductModel>>getProducts(
    // DocumentSnapshot? lastSnap
    )async{
  return await _fireDB
      .collection("products")
  // .orderBy("name")
      .get()
      .then((value) {
    // lastSnap = value.docs.last;
    var string = value.docs.map((e) => jsonEncode(e.data()));
    print(string);
    return value.docs
        .map((e) => ProductModel.fromJson(e.data()))
        .toList();
  });
    //  if (lastSnap == null) {
    //   return await _fireDB
    //       .collection("products")
    //       // .orderBy('name')
    //       .get()
    //       .then((value) {
    //     lastSnap = value.docs.last;
    //     // var string = value.docs.map((e) => jsonEncode(e.data()));
    //     // print(string);
    //     return value.docs
    //         .map((e) => ProductModel.fromJson(e.data()))
    //         .toList();
    //   });
    // } else {
    //   return await _fireDB
    //       .collection("products")
    //       // .orderBy("name")
    //       .get()
    //       .then((value) {
    //     lastSnap = value.docs.last;
    //     // var string = value.docs.map((e) => jsonEncode(e.data()));
    //     // print(string);
    //     return value.docs
    //         .map((e) => ProductModel.fromJson(e.data()))
    //         .toList();
    //   });
    // }
}

Future<void>updateProduct(ProductModel product)async{
  await _fireDB.collection("products").doc(product.id.toString()).update(product.toJson());
}

Future<void>deleteProduct(ProductModel product)async{
  await _fireDB.collection("products").doc(product.id.toString()).delete();
}



}