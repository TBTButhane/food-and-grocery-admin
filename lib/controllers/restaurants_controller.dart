// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shop4you_admin/models/restaurants_model.dart';
import 'package:shop4you_admin/widgets/app_const.dart';

import '../util/restaurants_repo.dart';

class RestaurantsController extends GetxController {
  final RestaurantsRepo restaurantsRepo;

  FirebaseFirestore _fireDB = FirebaseFirestore.instance;
  FirebaseStorage _fireStorage = FirebaseStorage.instance;
  List<RestaurantsModel> _allRestaurants = [];
  List<RestaurantsModel> get allRestaurants => _allRestaurants;
  RestaurantsModel? selectedRestaurantValue;
  RestaurantsModel? updatedSelectedRestaurantValue;
  DocumentSnapshot? _lastDocument;
  TextEditingController restaurantTitleController = TextEditingController();
  File? imageFile;
  RestaurantsController({
    required this.restaurantsRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ImagePicker picker = ImagePicker();

  @override
  onReady() {
    // _allRestaurants.bindStream();
  }

  //Add Restaurant

  Future<void> addRestaurant(String title, File logo) async {
    try {
      String id = generatedId();
      String logoUrl = await uploadImage(logo);
      Map<String, dynamic> restaurant = {
        "id": id,
        "name": title,
        "logo": logoUrl
      };

      await _fireDB.collection("restaurants").doc(id).set(restaurant);
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadImage(File file) async {
    try {
      String reslogo = generatedId();
      var logoRef =
          _fireStorage.ref().child("restaurant_logos").child("/$reslogo.jpg");
      var uploadTask = await logoRef.putFile(file);
      String url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> pickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        update();
      }
    });
  }

  //Fetch all restaurants from firebase
  Future<void> getRestaurants() async {
    _isLoading = true;
    _allRestaurants = [];
    update();
    // List<RestaurantsModel> resList =
    // await restaurantsRepo.getRestaurants(_lastDocument);
    List<RestaurantsModel> resList =
    await restaurantsRepo.getRestaurants();
    if(resList.isNotEmpty){
      for (var element in resList) {
        _allRestaurants.add(element);
      }
    }else{
      _allRestaurants = [];
    }
    _isLoading = false;
    update();
  }

  // Stream<List<RestaurantsModel>> restaurantStream(){
  //   return fireDB.collection("restaurants").snapshots().map((QuerySnapshot) => null)
  // }
  //update a single restaurant
  Future<void>updateRes(RestaurantsModel resModel)async{
    _isLoading =true;
    update();
    await restaurantsRepo.updateRes(resModel);
    _isLoading =false;
    update();
  }

  //delete a single restaurant
  Future<void> deleteRes(RestaurantsModel resModel)async {
    _isLoading = true;
    update();
    await restaurantsRepo.deleteRes(resModel);
    getRestaurants();
    _isLoading = false;
    update();
  }
}
