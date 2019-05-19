import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/ui/dailyMain.dart';
import 'package:mobile_project/ui/informationForm.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String user = "", pass = "";

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 7,
        navigateAfterSeconds: new AfterSplash(),
        image: new Image.asset("resource/logo.png"),
        backgroundColor: Colors.orange,
        photoSize: 150.0,
        loaderColor: Colors.white);
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
      backgroundColor: Colors.orange,
      key: _scaffoldKey,
      body: new Builder(
        builder: (BuildContext) {
          return SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
                children: <Widget>[
                  new Image.asset(
                    "resource/logo.png",
                    height: 250,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
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
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  TextFormField(
                    controller: _controller2,
                    decoration: InputDecoration(
                        labelText: "PASSWORD",
                        hintText: "Please Input Your PASSWORD",
                        icon: Icon(Icons.lock, size: 40, color: Colors.white),
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
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                  RaisedButton(
                    child: Text(
                      "ลงชื่อเข้าใช้",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      bool chk = false;

                      // auth.createUserWithEmailAndPassword(
                      //   email: user,
                      //   password: pass
                      // );
                      if (_formKey.currentState.validate()) {
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          dailyMain(user: userfire)));
                              ck = 1;
                            }
                            if (ck == 0) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InfromationForm(user: userfire)));
                            }
                          } else {
                            _displaySnackBar3(context);
                          }
                        });
                      }
                      if (chk == false) {
                        _displaySnackBar(context);
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
                    child: Text("สมัครสมาชิก", style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        auth
                            .createUserWithEmailAndPassword(
                          email: user,
                          password: pass,
                        )
                            .then((FirebaseUser userid) {
                          print(userid);
                          if (userid == null) {
                            _displaySnackBar(context);
                          }
                          try {
                            userid.sendEmailVerification();
                            Navigator.pushNamed(context, "/verify");
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
                        _displaySnackBar(context);
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
                ],
              ),
            ),
          );
        },
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
    final snackBar =
        SnackBar(content: Text('กรุณาลงทะเบียน หรือยืนยัน E-mailของท่านก่อน'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
