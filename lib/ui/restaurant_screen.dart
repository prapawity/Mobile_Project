import 'package:flutter/material.dart';
import 'package:mobile_project/model/restaurant_model.dart';
import 'package:mobile_project/ui/map.dart';


class RestaurantScreen extends StatelessWidget{

  final Restaurant restaurant;
  
  RestaurantScreen({this.restaurant});
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: ListView(
              children:<Widget>[
                    new Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 20, 50),
                        width: 220.0,
                        height: 220.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(restaurant.image)
                            )
                        )
                    ),
                    new Container(
                      padding: new EdgeInsets.all(32.0),
                      child: new Container(
                       child: Text(restaurant.description),
                      ),
                    ),
                  new Container(
                    child: RaisedButton(
                      child: Text("แผนที่"),
                      onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => new MapLocation(lat: restaurant.lat, lng: restaurant.lng)),);
                      },
                    ),
                    // child: new MapLocation(lat: restaurant.lat, lng: restaurant.lng)
                  )
              ] 
      ),
  );
  }
}