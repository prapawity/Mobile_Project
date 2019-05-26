import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/food_model.dart';

class Menu extends StatefulWidget {
  FirebaseUser user;
  Menu({this.user});
  @override
  _MenuState createState() => _MenuState();
}

//  theme: ThemeData(primaryColor: Color.fromARGB(255, 46, 196, 182)

class _MenuState extends State<Menu> {
  int number = 1;
  var _searchEdit = new TextEditingController();
  List<FoodElement> foods = new List<FoodElement>();
  bool _isSearch = true;
  String _searchText = "";

  Set<String> _searchListItems;
  Set<String> _searchListCal;

  @override
  // void initState() {
  //   super.initState();

  // }

  _MenuState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }
  getcal(String name){
    for(var j in foods){
      if(j.name == name){
        return j.cal;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("รายการอาหาร"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('calorie_food').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Text("ไม่พบข้อมูล"),
              );
            } else {
              return new Container(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                child: new Column(
                  children: <Widget>[
                    _searchBox(),
                    _isSearch
                        ? _listView(snapshot.data.documents, widget.user.email)
                        : _searchListView()
                  ],
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _searchBox() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
          hintText: "ค้นหาอาหารที่นี่!",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView(menu, String uid) {
    for (int i = 0; i < menu.length; i++) {
      if (menu[i]["food"] != null && menu[i].documentID == uid ||
          menu[i].documentID == "NqWIRf1CoiaIZKVUpXYp") {
        for (int j = 0; j < menu[i]["food"].length; j++) {
          FoodElement foodEl = new FoodElement(
              name: menu[i]["food"][j]["name"], cal: menu[i]["food"][j]["cal"]);
          foods.add(foodEl);
        }
      }
    }
    return new Flexible(
      child: new ListView.builder(
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                new ListTile(
                    title:
                        new Text("${foods[index].name} ${foods[index].cal} kcal"),
                    leading: Text((index + 1).toString()),
                    onTap: () {
                      _showDialog(index);
                    }),
                new Divider(
                  height: 2.0,
                ),
              ],
            );
          }),
    );
  }

  Widget _searchListView() {
    _searchListItems = new Set<String>();
    for (int i = 0; i < foods.length; i++) {
      var item = foods[i].name;

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        // _searchListCal.add(foods[i].cal);
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _searchListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                new ListTile(
                  
                    title:
                        new Text("${_searchListItems.elementAt(index)} ${getcal(_searchListItems.elementAt(index))} kcal"),
                    leading: Text((index + 1).toString()),
                    onTap: () {
                      _showDialog2(_searchListItems.elementAt(index));
                    }),
                new Divider(
                  height: 2.0,
                ),
              ],
            );
          }),
    );
  }

  void _showDialog(index) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("แจ้งเตือน"),
          content: new Text("ยืนยันการเลือกอาหารหรือไม่?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("ยืนยัน"),
              onPressed: () async {
                this.number = 1;
                List<Map<String, String>> list =
                    new List<Map<String, String>>();
                Map<String, String> list2 = Map<String, String>();
                Stream<DocumentSnapshot> test = await Firestore.instance
                    .collection('users.eat')
                    .document('${widget.user.email}')
                    .snapshots();
                // await test.elementAt(0).then((a){
                //   print(a.data.values.toList());
                // });
                await test.elementAt(0).then((a) {
                  for (var item in a.data.values.toList()[1]) {
                    print(number);
                    list2['name'] = '${this.number}. ${item['name']}';
                    list2['cal'] = item['cal'];
                    list.add(list2);
                    this.number += 1;
                  }
                });
                list2['name'] = '${this.number}. ${foods[index].name}';
                list2['cal'] = foods[index].cal;
                list.add(list2);
                Firestore.instance
                    .collection('users.eat')
                    .document(widget.user.email)
                    .updateData({"food": FieldValue.arrayUnion(list)});
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: new Text("ยกเลิก"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog2(String name) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("แจ้งเตือน"),
          content: new Text("ยืนยันการเลือกอาหารหรือไม่?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("ยืนยัน"),
              onPressed: () async {
                this.number = 1;
                List<Map<String, String>> list =
                    new List<Map<String, String>>();
                Map<String, String> list2 = Map<String, String>();
                Stream<DocumentSnapshot> test = await Firestore.instance
                    .collection('users.eat')
                    .document('${widget.user.email}')
                    .snapshots();
                // await test.elementAt(0).then((a){
                //   print(a.data.values.toList());
                // });
                await test.elementAt(0).then((a) {
                  for (var item in a.data.values.toList()[1]) {
                    print(number);
                    list2['name'] = '${this.number}. ${item['name']}';
                    list2['cal'] = item['cal'];
                    list.add(list2);
                    this.number += 1;
                  }
                });
                int state = 0;
                for (var j in foods) {
                  if (j.name == name) {
                    list2['name'] = '${this.number}. ${foods[state].name}';
                    list2['cal'] = foods[state].cal;
                    list.add(list2);
                  }
                  state += 1;
                }
                Firestore.instance
                    .collection('users.eat')
                    .document(widget.user.email)
                    .updateData({"food": FieldValue.arrayUnion(list)});
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: new Text("ยกเลิก"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
