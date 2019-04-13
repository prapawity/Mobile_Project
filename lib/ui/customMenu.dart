import 'package:flutter/material.dart';

Color myColor = Color(0x2ec4b6);

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  String _note;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: _note);
  }

   Widget _createAppBar(BuildContext context) {
    return new AppBar(
      actions: [
        new FlatButton(
          onPressed: () {
            Navigator
                .of(context);
          },
          child: Icon(Icons.add_circle, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(context),
      body: new Column(
        children: [
          new ListTile(
            leading: new Icon(Icons.kitchen, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'อาหารของคุณ',
              ),
              controller: _textController,
              // onChanged: (value) => _note = value,
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.fitness_center, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'พลังงาน (kcal)',
              ),
              // controller: _textController,
              // onChanged: () =>,
            ),
          ),
        ],
      ),
    );
  }
}
