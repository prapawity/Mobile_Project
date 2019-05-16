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
                    child: Text("SignIn"),
                    onPressed: () async {
                      bool chk = false;

                      // auth.createUserWithEmailAndPassword(
                      //   email: user,
                      //   password: pass
                      // );
                      if (_formKey.currentState.validate()) {
                        print("user: $user");
                        print("pass: $pass");
                        chk = true;
                        await auth
                            .signInWithEmailAndPassword(
                                email: user, password: pass)
                            .then((FirebaseUser userfire) {
                              String uid = userfire.uid;
                              Firestore.instance
                              .collection('users')
                              .document("$uid")
                              .setData({
                            'username': 'title',
                            'sex': 'male',
                            'date': '',
                            'imgurl': ''
                          });
                          print(userfire.uid);
                          print("----");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      dailyMain(user: userfire)));
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
                    child: Text("SignUp"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("signup $user $pass");
                        auth
                            .createUserWithEmailAndPassword(
                          email: user,
                          password: pass,
                        )
                            .then((FirebaseUser userid) {
                          Firestore.instance
                              .collection('users')
                              .document('{$userid.uid}')
                              .setData({
                            'username': 'title',
                            'sex': 'male',
                            'date': '',
                            'imgurl': ''
                          });
                                                    Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InfromationForm(user: userid)));
                        });
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
}
