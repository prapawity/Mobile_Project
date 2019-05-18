import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_project/service/user.dart';
import 'package:mobile_project/ui/menuList.dart';
import 'package:mobile_project/ui/restaurant_list_screen.dart';
import 'package:mobile_project/ui/updateinformationForm.dart';
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

Color labelColor = Colors.blue[200];

class dailyMainState extends State<dailyMain> {
  int state = 0;
  // Circular setup
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(200.0, 200.0);

// Tab setup
  final Map<int, Widget> pagelist = const <int, Widget>{
    0: Text("อาหาร"),
    1: Text("ร้านอาหาร"),
    2: Text("ออกกำลังกาย"),
  };
  final Map<int, Widget> icons = const <int, Widget>{
    0: Center(
      child: FlutterLogo(
        colors: Colors.indigo,
        size: 200.0,
      ),
    ),
    1: Center(
      child: FlutterLogo(
        colors: Colors.teal,
        size: 200.0,
      ),
    ),
    2: Center(
      child: FlutterLogo(
        colors: Colors.cyan,
        size: 200.0,
      ),
    ),
  };
  int sharedValue = 0;
  Widget buildUi(BuildContext context, userinfo nowuser) {
    double value = (nowuser.calnow / (nowuser.calmax / 100)).toDouble();
    if (state > 0) {
      value = (nowuser.calnow / (nowuser.calmax / 100)).toDouble();
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState.updateData(data);
    } else {
      setState(() {
        // List<CircularStackEntry> data = _generateChartData(0);
        // print(data);
        // _chartKey.currentState.updateData(data);
        
      });
      state = 1;
    }
    String imgprofile = "${nowuser.imgurl}";
    TextStyle _labelStyle = Theme.of(context)
        .textTheme
        .title
        .merge(new TextStyle(color: labelColor));

    return Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.user.email}"), centerTitle: true,
        // title: new Text("title ${widget.user.email}"),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Menu()));
        },
      ),
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('${widget.user.uid}'),
              accountEmail: new Text('${widget.user.email}'),
              currentAccountPicture: new GestureDetector(
                // InfromationForm
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new updateinformationForm(user: widget.user))),
                // onDoubleTap: () => print("profile click"),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(imgprofile),
                ),
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://www.sciencemag.org/sites/default/files/styles/article_main_large/public/images/running.jpg"))),
            ),
            new ListTile(
              title: new Text("restaurant"),
              trailing: new Icon(Icons.restaurant_menu),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ResraurantListScreen())),
            ),
            new ListTile(
              title: new Text("menulist"),
              trailing: new Icon(Icons.list),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Menu())),
            ),
            new ListTile(
              title: new Text("Graph"),
              trailing: new Icon(Icons.assessment),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Menu())),
            ),
            new ListTile(
              title: new Text("Add menu"),
              trailing: new Icon(Icons.add),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Add(user: widget.user,))),
            ),
            new ListTile(
              title: new Text("get Data firebase"),
              trailing: new Icon(Icons.add),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new getfirebase())),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Sign out"),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () => _signOut,
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
              holeLabel: '${nowuser.calnow} cal',
              labelStyle: _labelStyle,
            ),
            onPressed: () {
              print("clicked");
            },
          ),
          new SizedBox(
            height: 20,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 300.0,
                  child: CupertinoSegmentedControl<int>(
                    children: pagelist,
                    onValueChanged: (int val) {
                      setState(() {
                        sharedValue = val;
                      });
                    },
                    groupValue: sharedValue,
                  ))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 16.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 64.0,
                  horizontal: 16.0,
                ),
                child: icons[sharedValue],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    print("signout");
    Navigator.of(context).popAndPushNamed("/");
  }

  @override
  Widget build(BuildContext context) {
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

  @override
  void setState(fn) {
    // TODO: implement setState
  }
}

List<CircularStackEntry> _generateChartData(double value) {
  print('test $value');
  Color dialColor = Colors.blue[200];
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
