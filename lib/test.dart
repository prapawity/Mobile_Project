import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_project/ui/menuList.dart';
import 'package:mobile_project/ui/restaurant_list_screen.dart';
import 'package:mobile_project/ui/informationForm.dart';
import 'package:mobile_project/ui/login.dart';
import 'package:mobile_project/ui/customMenu.dart';
import 'package:mobile_project/ui/getdata.dart';
import 'package:mobile_project/service/userinfo.dart';

class dailyMain extends StatefulWidget {
  const dailyMain({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  dailyMainState createState() => dailyMainState();
}

class dailyMainState extends State<dailyMain> {


    Widget buildUi(BuildContext context, userinfo nowuser) {
  return Center(
    child: Text("$nowuser."),
  );
  }

  @override
  Widget build(BuildContext context) {
   return StreamBuilder<DocumentSnapshot>(
   stream: Firestore.instance.collection('users').document('${widget.user.uid}').snapshots(),
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();
          final  nowuser = userinfo.fromSnapshot(snapshot.data);
          return buildUi(context, nowuser);
   },
 );
  }
}
