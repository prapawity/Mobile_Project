import 'package:flutter/material.dart';
import 'package:mobile_project/styles/mainStyle.dart';

class ResraurantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านอาหาร"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var image = "https://www.tropical-islands.de/fileadmin/_processed_/6/6/csm_TI_RESTAURANT_PALMBEACH4_RGB_2000x860_add5f54263.jpg";
          String title = "title";
          var desc = "des";
          final cardIcon = Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            alignment: FractionalOffset.centerLeft,
            child: Image.network(image, height: 150.0, width: 150.0),
          );
          var cardText = Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  child: new Text(title, style: headerTextStyle),
                  padding: EdgeInsets.only(bottom: 15.0),
                ),
                Text(desc.length > 32 ? "${desc.substring(0, 32)}..." : desc)
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
      ),
    );
  }
}
