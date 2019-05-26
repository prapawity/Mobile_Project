import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_project/service/images_picker_dialog.dart';
import 'package:mobile_project/service/images_picker_handler.dart';
import 'package:mobile_project/service/userinfo.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_project/service/userinfo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'dailyMain.dart';

class updateinformationForm extends StatefulWidget {
  const updateinformationForm({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  updateinformationFormState createState() => new updateinformationFormState();
}

class updateinformationFormState extends State<updateinformationForm>
    with TickerProviderStateMixin, ImagePickerListener {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List _cities = [];
  var textfield_date = TextEditingController();
  var pic_date = new DateTime.now();
  int _radioValue1;
  int day, months, years;
  int age;
  var username = new TextEditingController();
  int _discreteValue = 1000;
  File _image;
  String userimg;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  static var httpClient = new HttpClient();
  @override
  void initState() {
    Firestore.instance
        .collection('users')
        .document('${widget.user.email}')
        .get()
        .then((DocumentSnapshot ds) {
      print("==================");
      print(_discreteValue);
      setState(() {
        username.text = ds.data['username'];
        textfield_date.text = ds.data['date'];
        _discreteValue = ds.data['calmax'];
        userimg = ds.data['imgurl'];
        if (ds.data['sex'] == "ผู้ชาย") {
          _radioValue1 = 0;
        } else {
          _radioValue1 = 1;
        }
      });
      // print("${widget.user.uid}");
      print("==================");
      // use ds as a snapshot
    });
    super.initState();
    for (var i = 1; i <= 100; i++) {
      _cities.add("$i");
    }
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    _dropDownMenuItems = getDropDownMenuItems();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
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
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: new ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: Container(
                  child: userimg == null
                      ? new Stack(
                          children: <Widget>[
                            new Center(
                                child: new Icon(
                              Icons.camera_alt,
                              size: 150,
                            )),
                          ],
                        )
                      : _image == null
                          ? new Container(
                              height: 160.0,
                              width: 160.0,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new NetworkImage("$userimg"),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: Color(0xff29487d), width: 5.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(80.0)),
                              ),
                            )
                          : new Container(
                              height: 160.0,
                              width: 160.0,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new ExactAssetImage(_image.path),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: Color(0xff29487d), width: 5.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(80.0)),
                              ),
                            ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
            TextField(
              controller: username,
              decoration: InputDecoration(
                labelText: "Username",
                hintText: "Please Input Your USER-NAME",
                icon: Icon(Icons.account_box, size: 40, color: Color(0xff29487d)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'ผู้ชาย',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'ผู้หญิง',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            TextField(
              onTap: datePicker,
              textAlign: TextAlign.center,
              // editable: false,
              // inputType: InputType.date,
              // initialDate: DateTime.now(),
              // format: DateFormat("yyyy-MM-dd"),
              controller: textfield_date,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Date of Birth",
              ),
            ),
            Text('แคลลอรี่ต่อวัน'),
            Slider(
              value: _discreteValue.roundToDouble(),
              min: 1000,
              max: 3000.0,
              divisions: 3000,
              label: '$_discreteValue',
              onChanged: (double value) {
                setState(() {
                  _discreteValue = value.round();
                });
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                print("SAce");
                String name = username.text;
                String sex = _radioValue1 == 0 ? 'Male' : 'Female';
                String date = textfield_date.text;
                String user = widget.user.email;
                FirebaseUser userobj = widget.user;
                int cal = _discreteValue;
                String namez = widget.user.email;
                String url;
                if (_image != null) {
                  final StorageReference storageRef =
                      FirebaseStorage.instance.ref().child('$namez');
                  final StorageUploadTask uploadTask =
                      storageRef.putFile(_image);
                  var dowurl =
                      await (await uploadTask.onComplete).ref.getDownloadURL();
                  url = dowurl.toString();
                }else{
                  url = userimg;
                }
                Firestore.instance
                    .collection('users')
                    .document('$user')
                    .updateData({
                  'date': '$date',
                  'imgurl': "$url",
                  'sex': '$sex',
                  'username': "$name",
                  'calmax': cal,
                });
                Navigator.pop(context);
              },
              color: Color(0xff29487d),
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

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  void datePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      maxYear: pic_date.year,
      locale: 'en',
      initialYear: pic_date.year,
      initialMonth: pic_date.month,
      initialDate: pic_date.day,
      cancel: Text('custom cancel'),
      confirm: Text('custom confirm'),
      dateFormat: 'dd-mmmm-yyyy',
      onChanged: (year, month, date) {
        textfield_date.text = "$date/$month/$year";
      },
      onConfirm: (year, month, date) {
        textfield_date.text = "$date/$month/$year";
        setState() {
          age = DateTime.now().year - year;
          print(age);
        }

        ;
      },
    );
  }
}
