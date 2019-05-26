import 'package:flutter/material.dart';
import 'package:mobile_project/model/restaurant_model.dart';
import 'package:mobile_project/ui/map.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantScreen({this.restaurant});

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(restaurant.name),centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        
        new Container(
          alignment: Alignment(0, 0),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: 220.0,
          height: 220.0,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(restaurant.image))),
        ),
        new Container(
          margin: EdgeInsets.all(10),
          child: new Container(
            child: Text(restaurant.description),
          ),
        ),
        new Container(
          margin: EdgeInsets.all(10),
          child: RaisedButton(
            color: Color(0xff29487d),
            child: Text("แผนที่",style: TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new MapLocation(
                        lat: restaurant.lat, lng: restaurant.lng, restaurant: restaurant,)),
              );
            },
          ),
          // child: new MapLocation(lat: restaurant.lat, lng: restaurant.lng)
        )
      ]),
    );
  }
}
