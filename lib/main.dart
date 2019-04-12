import 'package:flutter/material.dart';
import 'package:mobile_project/ui/login.dart';
import 'package:mobile_project/ui/informationForm.dart';
import 'package:mobile_project/ui/dailyMain.dart';
import 'package:mobile_project/ui/restaurant_list_screen.dart';

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
        // "/ResraurantListScreen": (context) =>ResraurantListScreen(),
        //  "/daily":  (context) =>dailyMain(),
        // "/third": (context) =>(SignUp()),

        },
    );
  }
}
