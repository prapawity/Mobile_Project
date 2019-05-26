import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class FeatureList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeatureListState();
  }

}
class FeatureListState extends State<FeatureList>{
   List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "กรุณายืนยัน E-mail ของท่าน",
        description: "คุณจะต้องทำการยืนยันอีเมลที่เราส่งไปในอีเมลของทคุณก่อนการใช้งาน LifeBoost",
        pathImage: "resource/email.png",
        backgroundColor: Color(0xff406E8E),
        
      ),
    );
    slides.add(
      new Slide(
        title: "การคำนวณแคลอรี่",
        description: "เราจะทำการเก็บแคลอรี่ในแต่ละวัน\nที่มาจากการรับประทานอาหารและออกกำลังกายของคุณ",
        pathImage: "resource/calculator.png",
        backgroundColor: Color(0xffD78521),
        
      ),
    );
    slides.add(
      new Slide(
        title: "การออกกำลังกาย",
        description: "เราจะแนะนำการออกกำลังกายที่จะช่วยเผาผลาญแคลอรี่ของคุณได้",
        pathImage: "resource/exercise.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "ร้านอาหาร",
        description:
        "เราจะแนะนำร้านอาหารที่อยู่ใกล้คุณ เพื่อที่คุณจะสามารถทราบที่อยู่และรายละเอียดของร้านอาหารที่สนใจได้",
        pathImage: "resource/res.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
    slides.add(
      new Slide(
        title: "แผนที่ร้านอาหาร",
        description:
        "เราจะแสดงแผนที่ของร้านอาหารที่คุณสนใจ",
        pathImage: "resource/map.png",
        backgroundColor: Color(0xff90323D),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }

}