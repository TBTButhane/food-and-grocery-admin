class RestaurantsModel {
  String? id;
  String? name;
  String? logo;

  RestaurantsModel({this.id, this.name, this.logo});

  // factory RestaurantsModel.fromJson(Map<String, dynamic> json) {
  //   return RestaurantsModel(
  //     id: json["id"],
  //     name: json["name"],
  //     logo: json["logo"]
  //   );
  // }
  RestaurantsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    logo = json["logo"] ?? "";
  }

  Map<String, dynamic> tojson() => {"id": id, "name": name, "logo": logo};
}
