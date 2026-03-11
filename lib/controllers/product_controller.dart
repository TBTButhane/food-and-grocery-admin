import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop4you_admin/models/addon.dart';
import 'package:shop4you_admin/models/product_model.dart';
import 'package:shop4you_admin/models/restaurants_model.dart';
import 'package:shop4you_admin/widgets/app_const.dart';

import '../util/products_repo.dart';

class ProductController extends GetxController {
  final ProductsRepo productsRepo;
  FirebaseFirestore _fireDB = FirebaseFirestore.instance;
  FirebaseStorage _fireStorage = FirebaseStorage.instance;
  List<ProductModel> _allProducts = [];
  List<ProductModel> get allProducts => _allProducts;
  List<AddonModel> _tempAddonList = [];
  List<AddonModel> get tempAllAddons => _tempAddonList;
  List<AddonModel> _addonList = [];
  List<AddonModel> get allAddons => _addonList;
  bool _isAllProductLoading = false;
  bool get isAllProductLoading => _isAllProductLoading;
  RestaurantsModel? dropDownValue;

  DocumentSnapshot? _lastDocument;
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController addonTitleController = TextEditingController();
  TextEditingController addonpriceController = TextEditingController();
  File? productImageFile;
  File? addonImageFile;
  bool hasAddons = false;
  bool _isPopular = false;
  // bool get hasAddons => _hasAddons;
  bool get isPopular => _isPopular;
  ImagePicker picker = ImagePicker();
  ProductController({required this.productsRepo});

  Future<void> addAddonToTempList(AddonModel addon) async {
    _tempAddonList.add(addon);
    addonpriceController.clear();
    addonTitleController.clear();
    addonImageFile = null;
    productImageFile = null;
    update();
  }

  Future<void> addProduct() async {
    _isAllProductLoading = true;
    update();
    int productId = 1;
    await getAllProducts();
    _allProducts.isEmpty ? productId = 1 : productId += _allProducts.length;

    // String prodId = generatedId();
    String addonId = generatedId();
    String proImage = await uploadProImage(productImageFile);

    RestaurantsModel restaurant = RestaurantsModel(
        id: dropDownValue!.id,
        name: dropDownValue!.name,
        logo: dropDownValue!.logo);
    //list of addons here

    if (_tempAddonList.isEmpty) {
      for (var ad in _tempAddonList) {
        String adnImage = await uploadAddonImage(addonImageFile);
        AddonModel addon = AddonModel(
            id: addonId,
            name: addonTitleController.text.trim(),
            image: adnImage,
            price: double.tryParse(addonpriceController.text.trim()));
        _addonList.add(addon);
      }
    } else {}

    ProductModel product = ProductModel(
      id: productId,
      desc: productDescController.text.trim(),
      hasAddon: hasAddons,
      image: proImage,
      name: productTitleController.text.trim(),
      popular: _isPopular,
      price: int.tryParse(productPriceController.text.trim()),
      addons: hasAddons ? _addonList : null,
      restaurantsModel: restaurant,
    );

    // print("final restaurant:${restaurant.name}, ${restaurant.id}, ${restaurant.logo}");
    // print("final addon:kfc");
    // print("final product:${product.toJson()}");
    _isAllProductLoading = false;
    await productsRepo.addProduct(product);
    productTitleController.clear();
    productPriceController.clear();
    productDescController.clear();
    addonpriceController.clear();
    addonTitleController.clear();
    addonImageFile = null;
    productImageFile = null;
    await getAllProducts();
    update();
  }

  Future<String> uploadProImage(File? productImage) async {
    try {
      String proImage = generatedId();
      var logoRef =
          _fireStorage.ref().child("product_images").child("/$proImage.jpg");
      var uploadTask = await logoRef.putFile(productImage!);
      String url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> getAllProducts() async {
    _isAllProductLoading = true;
    _allProducts = [];
    // List<ProductModel> proList =
    //    await productsRepo.getProducts(_lastDocument);
    update();
    List<ProductModel> proList = await productsRepo.getProducts();
    if (proList.isNotEmpty) {
      for (var element in proList) {
        _allProducts.add(element);
      }
    } else {
      _allProducts = [];
    }
    _isAllProductLoading = false;
    update();
  }

  Future<String> uploadAddonImage(File? productImage) async {
    try {
      String proImage = generatedId();
      var logoRef =
          _fireStorage.ref().child("addon_images").child("/$proImage.jpg");
      var uploadTask = await logoRef.putFile(productImage!);
      String url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> proPickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        productImageFile = File(value.path);
        update();
      }
    });
  }

  Future<void> addonPickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        addonImageFile = File(value.path);
        update();
      }
    });
  }

  Future<void> updateProduct(ProductModel productModel) async {
    _isAllProductLoading = true;
    update();
    await productsRepo.updateProduct(productModel);
    _isAllProductLoading = false;
    update();
  }

  Future<void> deleteProduct(ProductModel productModel) async {
    _isAllProductLoading = true;
    update();
    await productsRepo.deleteProduct(productModel);
    await getAllProducts();
    _isAllProductLoading = false;

    update();
  }
}
