import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:mobile_project/model/restaurant_model.dart';
import 'dart:io';

String url = 'http://api.halalthai.com/restaurant/?access_token=e807f1fcf82d132f9bb018ca6738a19f&sortby=place_name&orderby=asc';

Future<List<Restaurant>> getAllRestaurant() async {
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
