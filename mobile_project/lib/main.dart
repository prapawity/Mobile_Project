import 'package:flutter/material.dart';
import 'login.dart';
import 'informationForm.dart';
import 'dailyMain.dart';
import './restaurant_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) =>Splash(),
        "/information": (context) =>InfromationForm(),
        "/ResraurantListScreen": (context) =>ResraurantListScreen(),
        //  "/daily": (context) =>(InApp()),
        // "/third": (context) =>(SignUp()),

        },
    );
  }
}
