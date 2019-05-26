import 'package:flutter/material.dart';
import 'package:mobile_project/ui/exercise.dart';
import 'package:mobile_project/ui/login.dart';
import 'package:mobile_project/ui/informationForm.dart';

import 'package:mobile_project/ui/restaurant_list_screen.dart';
import 'package:mobile_project/ui/restaurant_screen.dart';



void main() => runApp(MyApp());
const MaterialColor white = const MaterialColor(
  0xff29487d,
  const <int, Color>{
    50: const Color(0xff29487d),
    100: const Color(0xff29487d),
    200: const Color(0xff29487d),
    300: const Color(0xff29487d),
    400: const Color(0xff29487d),
    500: const Color(0xff29487d),
    600: const Color(0xff29487d),
    700: const Color(0xff29487d),
    800: const Color(0xff29487d),
    900: const Color(0xff29487d),
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: white,
        fontFamily: 'Sukhumvit',
        appBarTheme: AppBarTheme(color: Color(0xff29487d)),
      ),
      initialRoute: "/",
      routes: {
         "/": (context) =>Splash(),
        // "/": (context) =>ResraurantListScreen(),   
        "/information": (context) =>InfromationForm(),
        "/ResraurantListScreen": (context) =>ResraurantListScreen(),
        "/restaurant_screen": (context) =>RestaurantScreen(),
        //  "/":  (context) =>dailyMain(),
        // "/third": (context) =>(SignUp()),
        "/exercise": (context) => exercise(),


        },
    );
  }
}
