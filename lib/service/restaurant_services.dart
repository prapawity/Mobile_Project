import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:mobile_project/model/restaurant_model.dart';
import 'dart:io';
import 'package:location/location.dart';
String url = 'http://api.halalthai.com/restaurant/?access_token=e807f1fcf82d132f9bb018ca6738a19f&sortby=place_name&orderby=asc';
var location = new Location();

Future<List<Restaurant>> getAllRestaurant(Map<String, double> userLocation) async {
   
   try{
     userLocation = await location.getLocation();
     url = 'http://api.halalthai.com/restaurant/place/nearby/?access_token=e807f1fcf82d132f9bb018ca6738a19f&lat='+
    userLocation["latitude"].toString() +'&lng='+userLocation["longitude"].toString()+'&distance=20&sortby=place_name&orderby=asc';
    print(userLocation["latitude"].toString());
    print(userLocation["longitude"].toString());
   }
   catch (e) {
     print(e);
    }
  
  final response = await http.get(url);
  print(response.body);
  return allRestaurantFromJson(response.body);
}

Future<Restaurant> getRestaurant() async{
  final response = await http.get('$url/1');
  return restaurantFromJson(response.body);
}

Future<http.Response> createRestaurant(Restaurant post) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: restaurantToJson(post)
  );
  return response;
}
