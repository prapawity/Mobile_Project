import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

//  theme: ThemeData(primaryColor: Color.fromARGB(255, 46, 196, 182)

class _MenuState extends State<Menu> {
  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _MenuListItems;
  List<String> _searchListItems;
  List<String> _CalListItems;

  @override
  void initState() {
    super.initState();
    _MenuListItems = new List<String>();
    _MenuListItems = [
      "Icecream",
      "Choc",
      "Banana",
      "Apple",
      "Crep",
      "Egg",
      "Grape",
      "Watermelon",
      "Orage",
      "Rice",
    ];
    _MenuListItems.sort();

    _CalListItems = new List<String>();
    _CalListItems = [
      "50 kcal",
      "10 kcal",
      "80 kcal",
      "30 kcal",
      "60 kcal",
      "90 kcal",
      "0 kcal",
      "100 kcal",
      "500 kcal",
      "50 kcal",
    ];
    _CalListItems.sort();

  }

  _MenuState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Food List"),
      ),
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
        child: new Column(
          children: <Widget>[
            _searchBox(),
            _isSearch ? _listView() : _searchListView()
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
          hintText: "Find your food here!",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _MenuListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.cyan[50],
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_MenuListItems[index]}    ${_CalListItems[index]}"),
              ),
            );
          }),
    );
  }

  Widget _searchListView() {
    _searchListItems = new List<String>();
    for (int i = 0; i < _MenuListItems.length; i++) {
      var item = _MenuListItems[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _searchListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Color.fromARGB(255, 203, 243, 240),
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_searchListItems[index]}, ${_CalListItems[index]}"),
              ),
            );
          }),
    );
  }
}