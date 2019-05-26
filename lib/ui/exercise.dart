import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class exercise extends StatelessWidget {
  final FirebaseUser user;
  const exercise({Key key, this.user}) : super(key: key);
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _name;
    String _cal;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ออกกำลังกาย'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'กิจกรรมที่ทำ',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("กรุณากรอกกิจกรรมที่ทำ");
                    } else {
                      _name = value;
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'หลังงานที่ใ้ช(แคลอรี่)',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("กรุณากรอกจำนวนพลังงานที่ใช้");
                    } else {
                      _cal = value;
                    }
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text('บันทึก'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      List<Map<String, String>> list =
                          new List<Map<String, String>>();

                      Map<String, String> list2 = Map<String, String>();
                      list2['name'] = _name;
                      list2['cal'] = _cal;

                      list.add(list2);

                      Firestore.instance
                          .collection('calorie_ex_user')
                          .document(user.email)
                          .updateData(
                              {"activity": FieldValue.arrayUnion(list)});
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
