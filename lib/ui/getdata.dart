// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class getfirebase extends StatefulWidget {
//   @override
//   getfirebaseState createState() => getfirebaseState();
// }
// class getfirebaseState extends State<getfirebase> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("get data"),
//       ),
//       body: StreamBuilder(
//         stream: Firestore.instance.collection('users').snapshots(),
//         builder: (context, snapshots){
//           if(!snapshots.hasData) return const Text("Loading...");
//           return Text(snapshots.data);
//         },
//         ),
//     );
//   }

// }