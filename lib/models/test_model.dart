// // To parse this JSON data, do
// //
// //     final shop4You = shop4YouFromJson(jsonString);

// import 'dart:convert';

// Shop4You shop4YouFromJson(String str) => Shop4You.fromJson(json.decode(str));

// String shop4YouToJson(Shop4You data) => json.encode(data.toJson());

// class Shop4You {
//   Shop4You({
//     required products,
//   }) {
//     this._products = products;
//   }

//   late List<Product> _products;
//   List<Product> get products => _products;

//   Shop4You.fromJson(dynamic json) {
//     if (json['products'] != null) {
//       _products = [];
//       json['products'].forEach((v) {
//         _products.add(Product.fromJson(v));
//       });
//     }
//   }
//   // factory Shop4You.fromJson(Map<String, dynamic> json) => Shop4You(
//   //       products: List<Product>.from(
//   //           json["products"].map((x) => Product.fromJson(x))),
//   //     );

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_products.isNotEmpty) {
//       map['products'] = _products.map((e) => e.toString()).toList();
//     }

//     return map;
//   }
//   // Map<String, dynamic> toJson() => {
//   //       "products": List<dynamic>.from(products!.map((x) => x.toJson())),
//   //     };
// }

// class Product {
//   Product({
//     this.id,
//     this.name,
//     this.desc,
//     this.image,
//     this.price,
//     this.hasAddon,
//     this.adons,
//     this.restaurant,
//   });
//   int? id;
//   String? name;
//   String? desc;
//   String? image;
//   int? price;
//   bool? hasAddon;
//   List<Adon>? adons;
//   Restaurant? restaurant;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//         desc: json["desc"],
//         image: json["image"],
//         price: json["price"],
//         hasAddon: json["hasAddon"],
//         adons: List<Adon>.from(json["adons"].map((x) => Adon.fromJson(x))),
//         restaurant: Restaurant.fromJson(json["restaurant"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "desc": desc,
//         "image": image,
//         "price": price,
//         "hasAddon": hasAddon,
//         "adons": List<dynamic>.from(adons!.map((x) => x.toJson())),
//         "restaurant": restaurant!.toJson(),
//       };
// }

// class Adon {
//   Adon({
//     this.id,
//     this.name,
//     this.price,
//   });
//   int? id;
//   String? name;
//   int? price;

//   factory Adon.fromJson(Map<String, dynamic> json) => Adon(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//       };
// }

// class Restaurant {
//   Restaurant({
//     this.id,
//     this.name,
//     this.location,
//     this.logo,
//   });
//   int? id;
//   String? name;
//   String? location;
//   String? logo;

//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//         id: json["id"],
//         name: json["name"],
//         location: json["location"],
//         logo: json["logo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "location": location,
//         "logo": logo,
//       };
// }
