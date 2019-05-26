import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class exercise extends StatelessWidget {
  final FirebaseUser user;
  final TextEditingController txtControl1;
  final TextEditingController txtControl2;
  const exercise({Key key, this.user, this.txtControl1, this.txtControl2})
      : super(key: key);
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _name;
    String _cal;
    return Scaffold(
      appBar: AppBar(
        title: Text('ออกกำลังกาย'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
              children: <Widget>[
                const Divider(height: 25.0),
                TextFormField(
                  controller: txtControl1,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: "กิจกรรมที่ทำ",
                    prefixIcon: Icon(Icons.accessibility_new),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "กรุณากรอกกิจกรรมที่ทำ";
                    }else {
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
                    hintText: "หลังงานที่ใ้ช(แคลอรี่)",
                    prefixIcon: Icon(Icons.fitness_center),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "กรุณากรอกจำนวนพลังงานที่ใช้";
                    }else {
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
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      Toast.show("โปรดกรอกข้อมูลให้ครบถ้วน", context,
                          gravity: Toast.BOTTOM);
                    } else {
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
          );
        },
      ),
      // oldForm(context, _name, _cal),
    );
  }

}
