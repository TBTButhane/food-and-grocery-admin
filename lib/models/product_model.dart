
import 'package:shop4you_admin/models/addon.dart';
import 'package:shop4you_admin/models/restaurants_model.dart';




class ProductModel {
  int? id;
  String? name;
  String? desc;
  String? image;
  int? price;
  bool? popular;
  bool? hasAddon;
  List<AddonModel>? addons;
  // AddonModel? addons;
  RestaurantsModel? restaurantsModel;

  ProductModel({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.price,
    this.popular,
    this.hasAddon,
    this.addons,
    this.restaurantsModel,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    desc = json["desc"] ?? "";
    image = json["image"] ?? "";
    price = json["price"] ?? "";
    popular = json["popular"] ?? false;
    hasAddon = json["hasAddon"] ?? false;
    addons = json["addons"] != null
        ? List<AddonModel>.from(
            json["addons"].map((x) => AddonModel.fromJson(x)))
        : null;
    // addons = json["addon"] != null?AddonModel.fromJson(json["addons"]):  null;
    restaurantsModel = RestaurantsModel.fromJson(json["restaurant"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "image": image,
        "price": price,
        "popular": popular,
        "hasAddon": hasAddon,
        // "addons": hasAddon != false?List<dynamic>.from(addons!.map((x) => x.toJson())): null,
        "addons": hasAddon != false?addons?.map((addon) => addon.toJson()).toList(): null,
        // "addons": hasAddon != false?addons!.toJson():null,
        "restaurant": restaurantsModel!.tojson(),
      };
}

