import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'images_picker_handler.dart';
import 'images_picker_dialog.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';

class InfromationForm extends StatefulWidget {
  @override
  informationState createState() => new informationState();
}

class informationState extends State<InfromationForm>
    with TickerProviderStateMixin, ImagePickerListener {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List _cities =[];
  String _currentCity;
  var textfield_date = TextEditingController();
  var pic_date = new DateTime.now();
  int _radioValue1 = 0;
  int day, months, years;
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
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
    _currentCity = _dropDownMenuItems[0].value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
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
                                child: new Icon(
                              Icons.camera_alt,
                              size: 150,
                            )),
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
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            TextField(
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Please Input Your USER-ID",
                  icon: Icon(Icons.account_box, size: 40, color: Colors.orange),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
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
                new Radio(
                  value: 2,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'อื่นๆ',
                  style: new TextStyle(fontSize: 16.0),
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
                labelText: "date",
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Container(
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(color: Colors.white),
              child: DropdownButton(
                  value: _currentCity,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            RaisedButton(
              child: Text("SignUp"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/ResraurantListScreen");
              },
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
      dateFormat: 'yyyy-mmmm-dd',
      onChanged: (year, month, date) {
        textfield_date.text = "$date/$month/$year";
      },
      onConfirm: (year, month, date) {
        textfield_date.text = "$date/$month/$year";
      },
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }


}

