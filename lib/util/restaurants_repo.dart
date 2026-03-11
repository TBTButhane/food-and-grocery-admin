import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/restaurants_model.dart';

class RestaurantsRepo {
  FirebaseFirestore _fireDB = FirebaseFirestore.instance;

//Getting  a list of all restaurants
  Future<List<RestaurantsModel>> getRestaurants(
      // DocumentSnapshot? _lastDocument
      ) async {
    return await _fireDB
        .collection("restaurants")
        .orderBy("name")
        .get()
        .then((value) {
      // _lastDocument = value.docs.last;
      return value.docs
          .map((e) => RestaurantsModel.fromJson(e.data()))
          .toList();
    });
    // if (_lastDocument == null) {
    //   return await _fireDB
    //       .collection("restaurants")
    //       .orderBy('name')
    //       .get()
    //       .then((value) {
    //     _lastDocument = value.docs.last;
    //
    //     return value.docs
    //         .map((e) => RestaurantsModel.fromJson(e.data()))
    //         .toList();
    //   });
    // } else {
    //   return await _fireDB
    //       .collection("restaurants")
    //       .orderBy("name")
    //       .get()
    //       .then((value) {
    //     _lastDocument = value.docs.last;
    //     return value.docs
    //         .map((e) => RestaurantsModel.fromJson(e.data()))
    //         .toList();
    //   });
    // }
  }

  //Delete Restaurants
  Future<void> deleteRes(RestaurantsModel resModel) async {
    await _fireDB.collection('restaurants').doc(resModel.id).delete();
  }

  //Update Restaurant
  Future<void>updateRes(RestaurantsModel resModel)async {
    await _fireDB.collection('restaurants').doc(resModel.id).update(resModel.tojson());
  }
}
