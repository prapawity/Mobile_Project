// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
    List<FoodElement> food = List<FoodElement>();

    Food({
        this.food,
    });

    factory Food.fromJson(Map<String, dynamic> json) => new Food(
        food: new List<FoodElement>.from(json["food"].map((x) => FoodElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "food": new List<dynamic>.from(food.map((x) => x.toJson())),
    };
    void append(FoodElement foodel){
      food.add(foodel);
    }
}

class FoodElement {
    String name;
    String cal;

    FoodElement({
        this.name,
        this.cal,
    });

    factory FoodElement.fromJson(Map<String, dynamic> json) => new FoodElement(
        name: json["name"],
        cal: json["cal"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "cal": cal,
    };
}
