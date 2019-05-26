import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/ui/dailyMain.dart';
import 'package:mobile_project/ui/featureList.dart';
import 'package:mobile_project/ui/informationForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String user = "", pass = "";

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

check_state_user(context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String email = sharedPreferences.getString("email");
  String password = sharedPreferences.getString("password");
  if (email != '' && password != '') {
    FirebaseAuth auth = await FirebaseAuth.instance;
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser userfire) async {
      SplashState2();
      if (userfire.isEmailVerified) {
        final QuerySnapshot result = await Firestore.instance
            .collection('users')
            .where('email', isEqualTo: userfire.email)
            .limit(1)
            .getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if (documents.length == 1) {
          print('171717171');
          return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => dailyMain(user: userfire)));
        }
      }
    });
  }
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      check_state_user(context);
    });
    return new Container(
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.3, 5],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xfff5a623),
            Color(0xfff5a623),
          ],
        ),
      ),
      child: Container(
        child: SplashScreen(
            seconds: 6,
            navigateAfterSeconds: new AfterSplash(),
            image: new Image.asset("resource/logo.png"),
            backgroundColor: Color(0xff29487d),
            photoSize: 150.0,
            loaderColor: Colors.white),
      ),
    );
  }
}

class SplashState2 extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.3, 5],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xfff5a623),
            Color(0xfff5a623),
          ],
        ),
      ),
      child: Wrap(
        children: <Widget>[
          SplashScreen(
              seconds: 10,
              navigateAfterSeconds: new AfterSplash(),
              image: new Image.asset("resource/logo.png"),
              backgroundColor: Colors.orange,
              photoSize: 100.0,
              loaderColor: Colors.white),
        ],
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool state = false, chk2 = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29487d),
      key: _scaffoldKey,
      body: Container(
        child: new Builder(
          builder: (BuildContext) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                  children: <Widget>[
                    new Image.asset(
                      "resource/logo.png",
                      height: 300,
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor: Colors.white,
                        primaryColorDark: Colors.white,
                        hintColor: Colors.white,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        style: new TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "UserName",
                            hintText: "Please Input Your UserName",
                            icon: Icon(Icons.account_box,
                                size: 40, color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (id) => print(id),
                        validator: (id) {
                          if (id.isEmpty) {
                            chk2 = true;
                            return "Please Input Your USER-ID";
                          } else {
                            user = id;
                          }
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                    Theme(
                      data: new ThemeData(
                          primaryColor: Colors.white,
                          primaryColorDark: Colors.white,
                          hintColor: Colors.white),
                          
                      child: TextFormField(
                        controller: _controller2,
                        style: new TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "PASSWORD",
                            hintText: "Please Input Your PASSWORD",
                            icon:
                                Icon(Icons.lock, size: 40, color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        obscureText: true,
                        onSaved: (password) => print(password),
                        validator: (password) {
                          if (password.isEmpty) {
                            chk2 = true;
                            return "Please Input Your PASSWORD";
                          } else {
                            pass = password;
                          }
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                    RaisedButton(
                      child: Text(
                        "ลงชื่อเข้าใช้",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        bool chk = false;

                        // auth.createUserWithEmailAndPassword(
                        //   email: user,
                        //   password: pass
                        // );
                        if (_formKey.currentState.validate()) {
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              backgroundColor: Color(0xff29487d),
                              duration: new Duration(seconds: 3),
                              content: new Center(
                                child: Container(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  alignment: Alignment(0.0, 0.0),
                                ),
                              )));

                          chk = true;
                          await auth
                              .signInWithEmailAndPassword(
                                  email: user, password: pass)
                              .then((FirebaseUser userfire) async {
                            if (userfire.isEmailVerified) {
                              int ck = 0;
                              final QuerySnapshot result = await Firestore
                                  .instance
                                  .collection('users')
                                  .where('email', isEqualTo: userfire.email)
                                  .limit(1)
                                  .getDocuments();
                              final List<DocumentSnapshot> documents =
                                  result.documents;
                              if (documents.length == 1) {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    'email', _controller.text);
                                sharedPreferences.setString(
                                    'password', _controller2.text);
                                print('qiuhsiuhqihdqd');
                                return Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            dailyMain(user: userfire)));
                              }
                              if (ck == 0) {
                                return Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InfromationForm(user: userfire)));
                              }
                            } else {
                              _displaySnackBar3(context);
                            }
                          }).catchError((e) {
                            _displaySnackBar4(context);
                          });
                        }
                        if (chk == false) {
                          _displaySnackBar4(context);
                        }
                        _controller.clear();
                        _controller2.clear();
                        chk2 = false;
                      },
                      color: Colors.blue,
                      splashColor: Colors.blueGrey,
                      textColor: Colors.white,
                    ),
                    RaisedButton(
                      child: Text("สมัครสมาชิก",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              backgroundColor: Color(0xff29487d),
                              duration: new Duration(seconds: 3),
                              content: new Center(
                                child: Container(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  alignment: Alignment(0.0, 0.0),
                                ),
                              )));
                          auth
                              .createUserWithEmailAndPassword(
                            email: user,
                            password: pass,
                          )
                              .then((FirebaseUser userid) {
                            if (userid == null) {
                              _displaySnackBar(context);
                            }
                            try {
                              userid.sendEmailVerification();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeatureList()));
                            } catch (e) {
                              _displaySnackBar(context);
                            }
                            //   String uid = userid.uid;
                            //   String test = _controller.text;
                            //   Firestore.instance
                            //       .collection('users')
                            //       .document('$test')
                            //       .setData({
                            //     'username': 'none',
                            //     'sex': 'none',
                            //     'date': 'none',
                            //     'imgurl': 'none',
                            //     'calmax': 2000,
                            //     'calnow': 0,
                            //   });
                            //   Firestore.instance
                            //     .collection('calorie_food')
                            //     .document(uid).setData({});

                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               InfromationForm(user: userid)));
                          }).catchError((e) {
                            _displaySnackBar2(context);
                          });
                        } else {
                          _displaySnackBar4(context);
                        }
                        // bool chk = false;
                        // _formKey.currentState.validate();
                        // UserPass.idPass.add([user,pass]);
                        // Navigator.pushNamed(context, "/information");
                        // chk = true;

                        // if (chk == false) {
                        //   _displaySnackBar(context);
                        // }
                        // _controller.clear();
                        // _controller2.clear();
                        // chk2 = false;
                        _controller.clear();
                        _controller2.clear();
                      },
                      color: Colors.white,
                      splashColor: Colors.blueGrey,
                      textColor: Colors.orange,
                    ),
                    // RaisedButton(child: Text('Test FeatureList'),onPressed: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => FeatureList()));
                    // },)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('USER or PASSWORD is Incorrect'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _displaySnackBar2(BuildContext context) {
    final snackBar = SnackBar(content: Text('E-mail นี้ถูกใช้ไปแล้ว'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _displaySnackBar3(BuildContext context) {
    final snackBar = SnackBar(
        content: Text('��รุณาลงทะเบียน หรือยืนยัน E-mailข���งท่านก่อน'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _displaySnackBar4(BuildContext context) {
    final snackBar = SnackBar(content: Text('กรุณากรอกข้อมูลให้ถูกห้อง'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
