import 'package:flutter/material.dart';
import 'data.dart';

class Information extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MySignUp();
  }
}

class MySignUp extends State<Information> {
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List authen = ["", "", ""];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "ข้อมูลส่วนตัว",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "USER-ID",
                  hintText: "Please Input Your USER-ID",
                  icon: Icon(Icons.email, size: 40, color: Colors.orange),
                ),
                onSaved: (user) => print(user),
                validator: (user) {
                  if (user.isEmpty) {
                    return "Please Input Your USER-ID";
                  } else {
                    authen[0] = user;
                  }
                },
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
              TextFormField(
                controller: _controller2,
                decoration: InputDecoration(
                  labelText: "PASSWORD",
                  hintText: "Please Input Your PASSWORD",
                  icon: Icon(Icons.lock, size: 40, color: Colors.orange),
                ),
                obscureText: true,
                onSaved: (password) => print(password),
                validator: (password) {
                  if (password.isEmpty) {
                    return "Please Input Your PASSWORD";
                  } else {
                    authen[1] = password;
                  }
                },
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
              TextFormField(
                controller: _controller3,
                decoration: InputDecoration(
                  labelText: "Confirm-PASSWORD",
                  hintText: "Please Input Your Confirm-PASSWORD",
                  icon: Icon(Icons.lock, size: 40, color: Colors.orange),
                ),
                obscureText: true,
                onSaved: (conpass) => print(conpass),
                validator: (conpass) {
                  if (conpass.isEmpty) {
                    return "Please Input Your Confirm Confirm-PASSWORD";
                  } else {
                    authen[2] = conpass;
                  }
                },
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
              RaisedButton(
                child: Text("Register New Account"),
                onPressed: () {
                  _formKey.currentState.validate();
                  if (authen[1] != authen[2]) {
                    _displaySnackBar(context, 1);
                  } else if (UserPass.idPass[0][0] == authen[0]) {
                    _displaySnackBar(context, 0);
                  } else if (authen[0] == "" ||
                      authen[1] == "" ||
                      authen[2] == "") {
                    _displaySnackBar(context, 2);
                  } else {
                    UserPass.idPass.add([authen[0], authen[1]]);
                    Navigator.pop(context);
                  }
                  _controller.clear();
                  _controller2.clear();
                  _controller3.clear();
                },
                color: Colors.orange,
                splashColor: Colors.blueGrey,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context, int state) {
    if (state == 0) {
      final snackBar = SnackBar(content: Text('USER is Used'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else if (state == 1) {
      final snackBar = SnackBar(content: Text('Password confirm is Incorrect'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else if (state == 2) {
      final snackBar =
          SnackBar(content: Text('Please input USER-ID and Password'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
