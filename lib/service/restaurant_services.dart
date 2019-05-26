import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:mobile_project/model/restaurant_model.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'dart:math';
String url = 'http://api.halalthai.com/restaurant/place/nearby/?access_token=e807f1fcf82d132f9bb018ca6738a19f&lat=13.729792&lng=100.78044159999999&distance=20&sortby=place_name&orderby=asc';
var location = new Location();

Future<List<Restaurant>> getAllRestaurant(Map<String, double> userLocation) async {
   print("try to get location");
   try{
     userLocation = await location.getLocation();
     print(userLocation["latitude"].toString());
     print(userLocation["longitude"].toString());
     if(userLocation["latitude"].toString() != null){
      url = 'http://api.halalthai.com/restaurant/place/nearby/?access_token=e807f1fcf82d132f9bb018ca6738a19f&lat='+
      userLocation["latitude"].toString() +'&lng='+userLocation["longitude"].toString()+'&distance=20&sortby=place_name&orderby=asc';
      Haversine.lat = double.parse(userLocation["latitude"].toString());
      Haversine.lng =  double.parse(userLocation["longitude"].toString());
     }else{
       print("cant get device location");
        Haversine.lat = 13.729792;
        Haversine.lng  = 100.78044159999999;
     }
   }
   catch (e) {
     print("cant get locations");
     print(e);
       Haversine.lat = 13.729792;
        Haversine.lng  = 100.78044159999999;
    }
  
  final response = await http.get(url);
  // print(response.body);
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



 // calculate distance between coodinate
class Haversine {
  static double lat, lng;
  static final R = 6372.8; // In kilometers
 
  static double haversine(double lat1, lon1, lat2, lon2) {
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    lat1 = _toRadians(lat1);
    lat2 = _toRadians(lat2);
    double a = pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return R * c;
  }
 
  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
 
  static void main() {
    print(haversine(36.12, -86.67, 33.94, -118.40));
  }
}