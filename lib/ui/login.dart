import 'package:flutter/material.dart';
import 'package:mobile_project/ui/dailyMain.dart';
import 'package:mobile_project/ui/informationForm.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                  InkWell(
                      child: Container(
                          constraints: BoxConstraints.expand(height: 50),
                          child: Text("Login with Google ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blue[600])),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.all(12)),
                      onTap: () => loginWithGoogle(context))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    bool isSigned = await _googleSignIn.isSignedIn();
    if (isSigned) {
      await _googleSignIn.signOut();
    }

    GoogleSignInAccount users = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await users.authentication;
    FirebaseUser eiei = await auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    int chk = 0;
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: eiei.email)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => dailyMain(user: eiei)));
      chk = 1;
    }
    if (chk == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => InfromationForm(user: eiei)));
    }
    // await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
    //     idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    // checkAuth(context); // after success route to home.
  }
}
