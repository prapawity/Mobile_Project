import 'package:flutter/material.dart';
import 'package:mobile_project/styles/mainStyle.dart';
import '../model/restaurant_model.dart';
import '../service/restaurant_services.dart';
import 'restaurant_screen.dart';
import 'package:location/location.dart';

class ResraurantListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResraurantListScreen();
  }
}

class _ResraurantListScreen extends State<ResraurantListScreen> {
  var location = new Location();

  Map<String, double> userLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff768AAC),
      appBar: AppBar(
        title: Text("ร้านอาหารที่ใกล้เคียง"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Restaurant>>(
          future: getAllRestaurant(userLocation),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error");
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Restaurant restaurant = snapshot.data[index];
                    String image = restaurant.image;
                    String title = restaurant.name;
                    String desc = restaurant.description;
                    final cardIcon = Container(
                      padding: const EdgeInsets.all(10.0),
                      // margin: EdgeInsets.symmetric(vertical: 10.0),
                      alignment: FractionalOffset.center,
                      child: Image.network(image),
                    );
                    var cardText = Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  new Text(
                                      title.length > 40
                                          ? "${title.substring(0, 40)}..."
                                          : title,
                                      style: headerTextStyle),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Text(
                                        "ระยะห่าง " +
                                            Haversine.haversine(
                                                    Haversine.lat,
                                                    Haversine.lng,
                                                    restaurant.lat,
                                                    restaurant.lng)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            " กม.",
                                        style: TextStyle(
                                            color: Colors.black,
                                            // fontSize: 10,
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  Container(
                                    // padding: EdgeInsets.all(10),
                                    child: Text(restaurant.detail.address+"\n"),
                                  ),
                                  Container(
                                    // padding: EdgeInsets.all(10),
                                    child: Text(desc.length >= 100
                                        ? "${desc.substring(0, 100)}..."
                                        : desc,
                                        style: TextStyle(
                                          fontSize: 12
                                        ),),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantScreen(
                                    restaurant: restaurant,
                                  )),
                        );
                      },
                      child: Card(
                        // color: Color(0xff9DABC3),
                        margin:
                            EdgeInsets.only(bottom: 10, left: 20, right: 20),

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: <Widget>[cardIcon, cardText],
                        ),
                      ),
                    );
                  },
                );
              }
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
