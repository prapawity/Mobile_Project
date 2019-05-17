import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class getfirebase extends StatefulWidget {
  @override
  getfirebaseState createState() => getfirebaseState();
}
class getfirebaseState extends State<getfirebase> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("get data"),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('baby').document('dana').snapshots(),
        builder: (context, snapshots) {
          var connect = snapshots.connectionState;
          var text = snapshots.data.data;
          switch(snapshots.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              return Row(children: <Widget>[
                Text("$text")
              ],);
          }
        },
        ),
    );
  }

}