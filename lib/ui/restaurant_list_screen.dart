import 'package:flutter/material.dart';
import 'package:mobile_project/styles/mainStyle.dart';
import '../model/restaurant_model.dart';
import '../service/restaurant_services.dart';

class ResraurantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านอาหาร"),
      ),
      body:FutureBuilder<List<Restaurant>>(
            future: getAllRestaurant(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasError){
                    return Text("Error");
                  }
                  else{

                    return    ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                  Restaurant restaurant = snapshot.data[index];
                                  String image = restaurant.image;
                                  String title = restaurant.name;
                                  String desc = restaurant.description;
                                  final cardIcon = Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Image.network(image, height: 150.0, width: 120.0),
                                  );
                                  var cardText = Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          child: new Text(title.length > 20 ? "${title.substring(0, 20)}..." : title, style: headerTextStyle),
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Text(desc.length > 23 ? "${desc.substring(0, 23)}..." : desc)
                                      ],
                                    ),
                                  );
                                  return InkWell(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) => PostScreen(title: title)));
                                    // },
                                    child: Card(
                                      margin: EdgeInsets.all(5.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0)),
                                      child: Row(
                                        children: <Widget>[cardIcon, cardText],
                                      ),
                                    ),
                                  );
                                },
                    );
                  }

              }
              else
                return Center(child: CircularProgressIndicator());
          }
    )  
      ,
    );
  }
}

