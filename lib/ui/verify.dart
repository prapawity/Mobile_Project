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
        children: <Widget>[
          Text('กรุณาตรวจสอบที่E-mailของท่าน'),
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
