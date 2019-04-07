import 'package:flutter/material.dart';

class dailyMain extends StatefulWidget {
  @override
  dailyMainState createState() => dailyMainState();
}

class dailyMainState extends State<dailyMain> {
  String imgprofile = "https://scontent.fbkk5-6.fna.fbcdn.net/v/t1.0-9/40432184_1828845493817855_5173684245750611968_o.jpg?_nc_cat=101&_nc_ht=scontent.fbkk5-6.fna&oh=aa1b368524a1ae602cd8d6a5e159fd91&oe=5D38E56E";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("title"),
        backgroundColor: Colors.orange,
      ),
      endDrawer: new Drawer(

        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("prchorn"),
              accountEmail: new Text("boom@it.com"),
              currentAccountPicture: new GestureDetector(
                onTap: () => print("profile click"),
                // onDoubleTap: () => print("profile click"),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(imgprofile),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage("https://www.sciencemag.org/sites/default/files/styles/article_main_large/public/images/running.jpg")
                )
              ),
            ),
            new ListTile(
              title: new Text("First page"),
              trailing: new Icon(Icons.arrow_upward),
              // onTap: () => print("first"),
            ),
            new ListTile(
              title: new Text("First page"),
              trailing: new Icon(Icons.arrow_upward),
              // onTap: () => print("first"),
            ),
            new Divider(),
            new ListTile(
              title: new Text("First page"),
              trailing: new Icon(Icons.arrow_upward),
              // onTap: () => print("first"),
            )
          ],
        ),
      ),
      body: new Center(
        child: new Text("hello", style: new TextStyle(fontSize: 35.0)),
      ),
    );
  }
}
