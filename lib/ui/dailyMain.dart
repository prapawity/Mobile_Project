import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_project/model/food_model.dart';
import 'package:mobile_project/model/restaurant_model.dart';
import 'package:mobile_project/service/restaurant_services.dart';
import 'package:mobile_project/service/user.dart';
import 'package:mobile_project/styles/mainStyle.dart';
import 'package:mobile_project/ui/exercise.dart';
import 'package:mobile_project/ui/menuList.dart';
import 'package:mobile_project/ui/restaurant_list_screen.dart';
import 'package:mobile_project/ui/restaurant_screen.dart';
import 'package:mobile_project/ui/updateinformationForm.dart';
import 'package:mobile_project/ui/informationForm.dart';
import 'package:mobile_project/ui/login.dart';
import 'package:mobile_project/ui/customMenu.dart';
import 'package:mobile_project/ui/getdata.dart';
import 'package:mobile_project/service/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class dailyMain extends StatefulWidget {
  const dailyMain({Key key, this.user}) : super(key: key);

  final FirebaseUser user;
  @override
  dailyMainState createState() => dailyMainState();
}

Color labelColor = Colors.blue[200];
int sharedValue = 0;

class dailyMainState extends State<dailyMain> {
  int statenow = 1;
  getListdata() async {
    Stream<DocumentSnapshot> dataget = await Firestore.instance
        .collection('users.eat')
        .document('${widget.user.email}')
        .snapshots();
    return dataget;
  }

  int number = 0;
  Map<String, double> userLocation;
  int chks = 0;
  int state = 0;
  // Circular setup
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(200.0, 200.0);

// Tab setup
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('อาหาร'),
    1: Text('ร้านอาหาร'),
    2: Text('ออกกำลังกาย'),
  };
  int sharedValue = 0;
  Widget food(BuildContext context) {
    if (state != 1) {
      state = 1;
      return CircularProgressIndicator();
    }
    return Container(
      height: 130,
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users.eat')
            .document('${widget.user.email}')
            .snapshots(),
        builder: (context, snapshort) {
          if (!snapshort.hasData) return CircularProgressIndicator();
          List<FoodElement> listFalse = new List<FoodElement>();
          if (snapshort.hasData) {
            for (var i = 0;
                i < snapshort.data.data.values.toList().elementAt(1).length;
                i++) {
              FoodElement e = new FoodElement(
                  cal:
                      '${snapshort.data.data.values.toList().elementAt(1)[i]["cal"]}',
                  name:
                      '${snapshort.data.data.values.toList().elementAt(1)[i]["name"]}');
              listFalse.add(e);
            }
            return listFalse.length != 0
                ? Container(
                    child: ListView.builder(
                      itemCount: listFalse.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          // title: Text('${listFalse.elementAt(index).name}'),
                          child: FlatButton(
                            color: Colors.transparent,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            splashColor: Colors.white,
                            child: ListTile(
                              subtitle: Text(
                                '${listFalse.elementAt(index).cal} kcal',
                                style: TextStyle(fontSize: 12),
                              ),
                              title: Text(
                                '${listFalse.elementAt(index).name}',
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: FlatButton(
                                padding: EdgeInsets.only(right: 0),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                splashColor: Colors.white,
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red[200],
                                ),
                                onPressed: () {
                                  setState(() {
                                    List<Map<String, String>> list =
                                        new List<Map<String, String>>();
                                    int chked = 0;
                                    number = 1;
                                    for (var item in listFalse) {
                                      Map<String, String> list2 =
                                          Map<String, String>();

                                      List namechk = item.name.split(' ');

                                      list2['name'] =
                                          '${number}. ${namechk[1]}';
                                      list2['cal'] = item.cal;
                                      if (list2['name'] !=
                                          listFalse.elementAt(index).name) {
                                        list.add(list2);
                                        number += 1;
                                      } else {
                                        if (chked > 0) {
                                          list.add(list2);
                                          number += 1;
                                        } else {
                                          chked = 1;
                                        }
                                      }
                                    }

                                    Firestore.instance
                                        .collection('users.eat')
                                        .document('${widget.user.email}')
                                        .updateData({'food': list}).catchError(
                                            (e) {});
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: ListTile(
                      subtitle: Text('อย่าลืมทานข้าวด้วยล่ะ'),
                      title: Text('วันนี้ยังไม่ได้ทานข้าวเลยนะ'),
                    ));
          }
        },
      ),
    );
  }

  Widget restaurant(BuildContext context) {
    state = 2;
    return Container(
      color: Colors.transparent,
      width: 300,
      height: 130,
      child: FutureBuilder<List<Restaurant>>(
          future: getAllRestaurant(userLocation),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error");
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Restaurant restaurant = snapshot.data[index];
                    String title = restaurant.name;
                    var cardText = Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Text(
                              title.length > 20
                                  ? "${title.substring(0, 20)}..."
                                  : title,
                              style: headerTextStyle),
                          new Text("ระยะห่าง " +
                              Haversine.haversine(Haversine.lat, Haversine.lng,
                                      restaurant.lat, restaurant.lng)
                                  .toStringAsFixed(2)
                                  .toString() +
                              " กม."),
                          Container(
                            child: Text(
                              restaurant.recommend.length > 30
                                  ? "${restaurant.recommend.substring(0, 30)}..."
                                  : restaurant.recommend,
                            ),
                          )
                        ],
                      ),
                    );

                    // Padding(padding: EdgeInsets.only(bottom: 10.0),)
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantScreen(
                                    restaurant: restaurant,
                                  )),
                        );
                      },
                      child: Card(
                        // color: Colors.amberAccent,
                        margin: EdgeInsets.all(5),

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: <Widget>[
                            snapshot.data.length == 0
                                ? Text('ไม่มีร้านอาหารในบริเวณใกล้เคียง')
                                : cardText
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget work(BuildContext context) {
    if (state != 3) {
      state = 3;
      return CircularProgressIndicator();
    }
    return Container(
      height: 130,
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('calorie_ex_user')
            .document('${widget.user.email}')
            .snapshots(),
        builder: (context, snapshort2) {
          if (!snapshort2.hasData) return CircularProgressIndicator();
          List<FoodElement> listFalse2 = new List<FoodElement>();
          if (snapshort2.hasData) {
            for (var i = 0;
                i < snapshort2.data.data.values.toList()[0].length;
                i++) {
              FoodElement z = new FoodElement(
                  cal: '${snapshort2.data.data.values.toList()[0][i]['cal']}',
                  name:
                      '${snapshort2.data.data.values.toList()[0][i]['name']}');
              listFalse2.add(z);
            }
            getcalories();
            return listFalse2.length != 0
                ? Container(
                    child: ListView.builder(
                      itemCount: listFalse2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          // title: Text('${listFalse.elementAt(index).name}'),
                          child: FlatButton(
                            color: Colors.transparent,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            splashColor: Colors.white,
                            child: ListTile(
                              subtitle: Text(
                                '${listFalse2.elementAt(index).cal} kcal',
                                style: TextStyle(fontSize: 12),
                              ),
                              title: Text(
                                '${listFalse2.elementAt(index).name}',
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: FlatButton(
                                padding: EdgeInsets.only(right: 0),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                splashColor: Colors.white,
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red[200],
                                ),
                                onPressed: () async {
                                  List<Map<String, String>> list =
                                      new List<Map<String, String>>();
                                  setState(() {
                                    int chked = 0;
                                    number = 1;
                                    for (var item in listFalse2) {
                                      Map<String, String> list2 =
                                          Map<String, String>();

                                      list2['name'] = '${item.name}';
                                      list2['cal'] = item.cal;

                                      if (list2['name'] !=
                                          listFalse2.elementAt(index).name) {
                                        list.add(list2);
                                      }
                                    }
                                  });
                                  await Firestore.instance
                                      .collection('calorie_ex_user')
                                      .document('${widget.user.email}')
                                      .updateData({
                                    'activity': list
                                  }).catchError((e) {});
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: ListTile(
                      subtitle: Text('อย่าลืมทานขาวด้วยล่ะ'),
                      title: Text('วันนี้ยังไม่ได้ทานข้าวเลยนะ'),
                    ));
          }
        },
      ),
    );
  }

  Widget buildUi(BuildContext context, userinfo nowuser) {
    double value = (nowuser.calnow / (nowuser.calmax / 100)).toDouble();
    if (state > 0 || chks != 0) {
      value = (nowuser.calnow / (nowuser.calmax / 100)).toDouble();
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState.updateData(data);
    } else {
      if (chks != 0) {
        setState(() {
          List<CircularStackEntry> data = _generateChartData(0);

          _chartKey.currentState.updateData(data);
        });
      }
      state = 1;
    }
    chks++;
    String imgprofile = "${nowuser.imgurl}";
    TextStyle _labelStyle = Theme.of(context).textTheme.title.merge(
        new TextStyle(
            color: labelColor, fontSize: 18, fontWeight: FontWeight.bold));

    return Container(
      decoration: BoxDecoration(
          image: new DecorationImage(
        image: new AssetImage("resource/bg4.jpg"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          title: new Text(
            "${nowuser.username}",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          // title: new Text("title ${widget.user.email}"),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff29487d),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color(0xff29487d),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xff29487d),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Color(0xff29487d),
          ),
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new Menu(user: widget.user)));
          },
        ),
        endDrawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text(
                  '${nowuser.username}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                accountEmail: new Text(
                  '${widget.user.email}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                currentAccountPicture: new GestureDetector(
                  // InfromationForm
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new updateinformationForm(user: widget.user))),

                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(imgprofile),
                    backgroundColor: Colors.white,
                  ),
                ),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkN2vSHb57BWkqpxHJkc9gqtcFdXNPBQDtoSPstPMEYl-ZVLMj"))),
              ),
              new ListTile(
                title: new Text("แก้ไขข้อมูลส่วนตัว"),
                trailing: new Icon(Icons.person),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new updateinformationForm(user: widget.user))),
              ),
              new ListTile(
                title: new Text("ร้านอาหาร"),
                trailing: new Icon(Icons.restaurant_menu),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ResraurantListScreen())),
              ),
              new ListTile(
                title: new Text("รายการอาหาร"),
                trailing: new Icon(Icons.list),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new Menu(user: widget.user))),
              ),
              new ListTile(
                title: new Text("เพิ่มรายการอาหาร"),
                trailing: new Icon(Icons.add),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Add(
                          user: widget.user,
                        ))),
              ),
              new ListTile(
                title: new Text("ออกกำลังกาย"),
                trailing: new Icon(Icons.add),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new exercise(
                          user: widget.user,
                        ))),
              ),
              new Divider(),
              new ListTile(
                title: new Text("ออกจากระบบ"),
                trailing: new Icon(Icons.exit_to_app),
                onTap: () => _signOut(),
              )
            ],
          ),
        ),
        body: new Container(
          padding: EdgeInsets.all(30.0),
          child: new Column(children: <Widget>[
            FlatButton(
              child: new AnimatedCircularChart(
                key: _chartKey,
                size: _chartSize,
                initialChartData: _generateChartData(value),
                chartType: CircularChartType.Radial,
                edgeStyle: SegmentEdgeStyle.round,
                percentageValues: true,
                holeLabel: '${nowuser.calnow} กิโลแคลอรี่',
                labelStyle: _labelStyle,
              ),
            ),
            new Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 500.0,
                  child: CupertinoSegmentedControl<int>(
                    children: logoWidgets,
                    onValueChanged: (int val) {
                      setState(() {
                        sharedValue = val;
                      });
                    },
                    groupValue: sharedValue,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: sharedValue == 0
                          ? food(context)
                          : sharedValue == 1
                              ? restaurant(context)
                              : work(context)),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future _signOut() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', '');
    sharedPreferences.setString('password', '');
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  getcalories() async {
    double cal = 0;
    List<FoodElement> listchk1 = new List<FoodElement>();
    List<FoodElement> listchk2 = new List<FoodElement>();
    Stream<DocumentSnapshot> chk = await Firestore.instance
        .collection('users.eat')
        .document(widget.user.email)
        .snapshots();
    await chk.elementAt(0).then((a) {
      for (var i = 0; i < a.data.values.toList()[1].length; i++) {
        FoodElement e = new FoodElement(
            cal: '${a.data.values.toList()[1][0]['cal']}',
            name: '${a.data.values.toList()[1][0]['name']}');
        listchk1.add(e);
      }
    });
    Stream<DocumentSnapshot> chk2 = await Firestore.instance
        .collection('calorie_ex_user')
        .document('${widget.user.email}')
        .snapshots();
    await chk2.elementAt(0).then((a) {
      for (var i = 0; i < a.data.values.toList()[0].length; i++) {
        FoodElement e = new FoodElement(
            cal: '${a.data.values.toList()[0][0]['cal']}',
            name: '${a.data.values.toList()[0][0]['name']}');
        listchk2.add(e);
      }
    });
    for (var i in listchk1) {
      cal = cal + int.parse(i.cal);
    }
    for (var i in listchk2) {
      cal = cal - int.parse(i.cal);
    }
    if (cal < 0) cal = 0;
    Firestore.instance
        .collection('users')
        .document('${widget.user.email}')
        .updateData({'calnow': cal});
  }

  checkdate() async {
    await Firestore.instance
        .collection('users.eat')
        .document(widget.user.email)
        .get()
        .then((a) async {
      List day = '${DateTime.now()}'.split(' ');
      List day2 = '${a.data.values.toList().elementAt(0)}'.split(' ');
      if ('${day2[0]}'.compareTo('${day[0]}') < 0) {
        await Firestore.instance
            .collection('users.eat')
            .document(widget.user.email)
            .updateData({'date': '${DateTime.now()}', 'food': []});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      checkdate();
      getcalories();
    });
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document('${widget.user.email}')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        final nowuser = userinfo.fromSnapshot(snapshot.data);
        return buildUi(context, nowuser);
      },
    );
  }
}

List<CircularStackEntry> _generateChartData(double value) {
  Color dialColor = Colors.orange;
  if (value < 0) {
    dialColor = Colors.red[200];
  } else if (value < 50) {
    dialColor = Colors.red[200];
  }
  labelColor = dialColor;

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(
          value,
          dialColor,
          rankKey: 'percentage',
        )
      ],
      rankKey: 'percentage',
    ),
  ];

  if (value > 100) {
    labelColor = Colors.green[200];

    data.add(new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(
          value - 100,
          Colors.green[200],
          rankKey: 'percentage',
        ),
      ],
      rankKey: 'percentage2',
    ));
  }

  return data;
}
