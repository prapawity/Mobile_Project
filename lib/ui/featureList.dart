import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class FeatureList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeatureListState();
  }
}

class FeatureListState extends State<FeatureList> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "กรุณายืนยัน E-mail ของท่าน",
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
        description:
            "คุณจะต้องทำการยืนยันอีเมลที่เราส่งไปในอีเมลของทคุณก่อนการใช้งาน LifeBoost",
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        pathImage: "resource/email.png",
        backgroundColor: Colors.black,
      ),
    );
    slides.add(
      new Slide(
        title: "การคำนวณแคลอรี่",
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        description:
            "เราจะทำการเก็บแคลอรี่ในแต่ละวัน\nที่มาจากการรับประทานอาหารและออกกำลังกายของคุณ",
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        pathImage: "resource/calculator.png",
        backgroundColor: Color(0xffD78521),
      ),
    );
    slides.add(
      new Slide(
        title: "การออกกำลังกาย",
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        description: "เราจะแนะนำการออกกำลังกายที่จะช่วยเผาผลาญแคลอรี่ของคุณได้",
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        pathImage: "resource/exercise.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "ร้านอาหาร",
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        description:
            "เราจะแนะนำร้านอาหารที่อยู่ใกล้คุณ เพื่อที่คุณจะสามารถทราบที่อยู่และรายละเอียดของร้านอาหารที่สนใจได้",
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        pathImage: "resource/res.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
    slides.add(
      new Slide(
        title: "แผนที่ร้านอาหาร",
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
        description: "เราจะแสดงแผนที่ของร้านอาหารที่คุณสนใจ",
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        pathImage: "resource/map.png",
        backgroundColor: Color(0xff90323D),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pop(context);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(Icons.done, color: Colors.white);
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LifeBoost"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: new IntroSlider(
          // List slides
          slides: this.slides,
          // Skip button
          renderSkipBtn: this.renderSkipBtn(),
          colorSkipBtn: Color(0xff223B67),
          highlightColorSkipBtn: Color(0xffffcc5c),

          // Next button
          renderNextBtn: this.renderNextBtn(),

          // Done button
          renderDoneBtn: this.renderDoneBtn(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Color(0xff223B67),
          highlightColorDoneBtn: Color(0xffffcc5c),

          // Dot indicator
          colorDot: Color(0xffD0DAE6),
          colorActiveDot: Color(0xff547AA5),
          sizeDot: 13.0,

          // List custom tabs
          listCustomTabs: this.renderListCustomTabs(),

          // Show or hide status bar
          shouldHideStatusBar: true,

          // On tab change completed
          onTabChangeCompleted: this.onTabChangeCompleted,
        ),
      ),
    );
  }
}
