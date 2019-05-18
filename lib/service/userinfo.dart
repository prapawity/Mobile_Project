import 'package:cloud_firestore/cloud_firestore.dart';



class userinfo {
  String username;
  String sex;
  String imgurl;
  String date;
  int calmax;
  int calnow;
  final DocumentReference reference;

  userinfo.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['username'] != null),
        assert(map['sex'] != null),
        assert(map['imgurl'] != null),
        assert(map['date'] != null),
        assert(map['calmax'] != null),
        assert(map['calnow'] != null),
        username = map['username'],
        sex = map['sex'],
        imgurl = map['imgurl'],
        date = map['date'],
        calmax = map['calmax'],
        calnow = map['calnow'];
  userinfo.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "$username <$imgurl:$sex>";
}