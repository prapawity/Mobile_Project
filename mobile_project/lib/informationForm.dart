import 'dart:io';
import 'package:flutter/material.dart';
import 'images_picker_handler.dart';
import 'images_picker_dialog.dart';

class InfromationForm extends StatefulWidget {
  @override
  informationState createState() => new informationState();
}

class informationState extends State<InfromationForm>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "Personal Information",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,iconTheme: IconThemeData(color: Colors.white),
        ),
        body: new ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: _image == null
                      ? new Stack(
                          children: <Widget>[
                            new Center(
                              child: new Icon(Icons.camera_alt,size: 150,)
                            ),
                          ],
                        )
                      : new Container(
                          height: 160.0,
                          width: 160.0,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new ExactAssetImage(_image.path),
                              fit: BoxFit.cover,
                            ),
                            border:
                                Border.all(color: Colors.orange, width: 5.0),
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(80.0)),
                          ),
                        ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            TextField(
              decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Please Input Your USER-ID",
                  icon: Icon(Icons.account_box, size: 40, color: Colors.orange),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            TextField(
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Please Input Your USER-ID",
                  icon: Icon(Icons.account_box, size: 40, color: Colors.orange),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            RaisedButton(
              child: Text("SignUp"),
              onPressed: () {},
              color: Colors.orange,
              splashColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
          ],
        ));
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
