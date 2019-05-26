import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class ForgetPasswordPage extends StatelessWidget {
  TextEditingController txtControl1;
  TextEditingController txtControl2;
  final _scaffoldKey2 = GlobalKey<ScaffoldState>();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _name;
    String _cal;
    return Scaffold(
      key: _scaffoldKey2,
      appBar: AppBar(
        title: Text('ลืมรหัสผ่าน'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
              children: <Widget>[
                TextFormField(
                  controller: txtControl1,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: "อีเมล",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "กรุณากรอกอีเมลของท่าน";
                    } else {
                      _name = value;
                    }
                  },
                ),
                const Divider(height: 5.0),
                TextFormField(
                  controller: txtControl2,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: "ชื่อ",
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "กรุณากรอกชื่อของท่าน";
                    } else {
                      _cal = value;
                    }
                  },
                ),
                const Divider(height: 15.0),
                RaisedButton(
                  color: Color(0xff29487d),
                  child: Text(
                    "เพิ่ม",
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      Toast.show("โปรดกรอกข้อมูลให้ครบถ้วน", context,
                          gravity: Toast.BOTTOM);
                    } else {
                      _scaffoldKey2.currentState.showSnackBar(new SnackBar(
                          backgroundColor: Color(0xff29487d),
                          duration: new Duration(seconds: 2),
                          content: new Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                              alignment: Alignment(0.0, 0.0),
                            ),
                          )));
                      DocumentSnapshot data = await Firestore.instance
                          .collection('users')
                          .document('${_name}')
                          .get();
                      if (data.data != null) {
                        print(data.data.containsValue('${_cal}'));
                        if (data.data.containsValue('${_cal}')) {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: '${_name}');
                          Toast.show("กรุณาดูที่อีเมลของท่าน", context,
                              gravity: Toast.BOTTOM,
                              duration: Toast.LENGTH_SHORT);

                          Navigator.pop(context);
                        } else {
                          Toast.show("ไม่มีข้อมูลบัญชีผู้ใช้", context,
                              gravity: Toast.BOTTOM,
                              duration: Toast.LENGTH_SHORT);
                        }
                      } else {
                        Toast.show("ไม่มีข้อมูลบัญชีผู้ใช้", context,
                            gravity: Toast.BOTTOM,
                            duration: Toast.LENGTH_SHORT);
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      // oldForm(context, _name, _cal),
    );
  }
}

//    for (var item in a.data.values.toList()){
//      print(item);
//    }
// if (a.data.values == null) {
//   Toast.show("ไม่มีข้อมูลบัญชีผู้ใช้", context,
//       gravity: Toast.BOTTOM,
//       duration: Toast.LENGTH_SHORT);
// } else if (a.data.containsValue('${_cal}') != null) {
//   await FirebaseAuth.instance
//       .sendPasswordResetEmail(email: '${_name}');
//   Toast.show("กรุณาดูที่อีเมลของท่าน", context,
//       gravity: Toast.BOTTOM,
//       duration: Toast.LENGTH_SHORT);
//   _scaffoldKey2.currentState.showSnackBar(new SnackBar(
//       backgroundColor: Color(0xff29487d),
//       duration: new Duration(seconds: 2),
//       content: new Center(
//         child: Container(
//           child: CircularProgressIndicator(
//             backgroundColor: Colors.white,
//           ),
//           alignment: Alignment(0.0, 0.0),
//         ),
//       )));
//   Navigator.pop(context);
// } else {
//   Toast.show("ไม่มีข้อมูลบัญชีผู้ใช้", context,
//       gravity: Toast.BOTTOM,
//       duration: Toast.LENGTH_SHORT);
// }
