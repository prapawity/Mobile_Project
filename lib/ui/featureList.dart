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
        title: "การคำนวณแคลอรี่",
        description: "เราจะทำการแคลอรี่ของท่านในแต่ละวัน\nที่มาจากการกินและการออกกำลังกายของท่าน",
        pathImage: "resource/calculator.png",
        backgroundColor: Color(0xfff5a623),
        
      ),
    );
    slides.add(
      new Slide(
        title: "การออกกำลังกาย",
        description: "เราจะเก็บประวัติการออกกำลังการของท่านในแต่ละวัน\nเพื่อท่านจะสามารถรู้จำนวนแคลอรี่ที่ท่านได้ใช้ไปในแต่ละวันได้",
        pathImage: "resource/exercise.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "ร้านอาหาร",
        description:
        "เราจะแนะนำร้านอาหารที่อยู่ใกล้ท่าน เพื่อที่ท่านจะสามารถทราบที่อยู่ของร้านอาหารที่ท่านสนใจได้",
        pathImage: "resource/res.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
    slides.add(
      new Slide(
        title: "แผนที่ร้านอาหาร",
        description:
        "เราจะแสดงแผนที่ของร้านอาหารที่ท่านสนใจ",
        pathImage: "resource/map.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    print('test');
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