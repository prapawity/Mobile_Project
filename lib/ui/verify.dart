import 'package:flutter/material.dart';

class verifying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('กรุณายืนยันEmailของคุณ'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('กรุณาตรวจสอบที่E-mailของท่าน',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          RaisedButton(
            child: Text('ยืนยัน'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )),
    );
  }
}
