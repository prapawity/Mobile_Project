// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

Restaurant restaurantFromJson(String str) {
    final jsonData = json.decode(str);
    return Restaurant.fromJson(jsonData);
}

String restaurantToJson(Restaurant data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

List<Restaurant> allRestaurantFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Restaurant>.from(jsonData.map((x) => Restaurant.fromJson(x)));
}

String allRestaurantToJson(List<Restaurant> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}


class Restaurant {
    int placeId;
    String name;
    String image;
    int rate;
    String province;
    Category category;
    Subcategory subcategory;
    double lat;
    double lng;
    List<Facility> facilities;
    String description;
    String recommend;
    List<dynamic> gallery;
    Detail detail;
    int isRecommend;

    Restaurant({
        this.placeId,
        this.name,
        this.image,
        this.rate,
        this.province,
        this.category,
        this.subcategory,
        this.lat,
        this.lng,
        this.facilities,
        this.description,
        this.recommend,
        this.gallery,
        this.detail,
        this.isRecommend,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => new Restaurant(
        placeId: json["place_id"],
        name: json["name"],
        image: json["image"],
        rate: json["rate"],
        province: json["province"],
        category: Category.fromJson(json["category"]),
        subcategory: Subcategory.fromJson(json["subcategory"]),
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        facilities: new List<Facility>.from(json["facilities"].map((x) => Facility.fromJson(x))),
        description: json["description"],
        recommend: json["recommend"],
        gallery: new List<dynamic>.from(json["gallery"].map((x) => x)),
        detail: Detail.fromJson(json["detail"]),
        isRecommend: json["is_recommend"],
    );

    Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "name": name,
        "image": image,
        "rate": rate,
        "province": province,
        "category": category.toJson(),
        "subcategory": subcategory.toJson(),
        "lat": lat,
        "lng": lng,
        "facilities": new List<dynamic>.from(facilities.map((x) => x.toJson())),
        "description": description,
        "recommend": recommend,
        "gallery": new List<dynamic>.from(gallery.map((x) => x)),
        "detail": detail.toJson(),
        "is_recommend": isRecommend,
    };
}

class Category {
    String name;
    String image;

    Category({
        this.name,
        this.image,
    });

    factory Category.fromJson(Map<String, dynamic> json) => new Category(
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
    };
}

class Detail {
    String website;
    String facebook;
    String googlePlus;
    String email;
    String address;
    List<String> phone;
    List<String> time;

    Detail({
        this.website,
        this.facebook,
        this.googlePlus,
        this.email,
        this.address,
        this.phone,
        this.time,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => new Detail(
        website: json["website"],
        facebook: json["facebook"],
        googlePlus: json["google_plus"],
        email: json["email"],
        address: json["address"],
        phone: new List<String>.from(json["phone"].map((x) => x)),
        time: new List<String>.from(json["time"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "website": website,
        "facebook": facebook,
        "google_plus": googlePlus,
        "email": email,
        "address": address,
        "phone": new List<dynamic>.from(phone.map((x) => x)),
        "time": new List<dynamic>.from(time.map((x) => x)),
    };
}

class Facility {
    int name;
    String image;

    Facility({
        this.name,
        this.image,
    });

    factory Facility.fromJson(Map<String, dynamic> json) => new Facility(
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
    };
}

class Subcategory {
    int id;
    String name;
    String image;

    Subcategory({
        this.id,
        this.name,
        this.image,
    });

    factory Subcategory.fromJson(Map<String, dynamic> json) => new Subcategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
