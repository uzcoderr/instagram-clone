import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/User.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';

class DataService {

  static Future storeUser(MyUser user) async {
    user.uid = (await Prefs.loadUserId())!;
    // user.uid = "sssssssssssssssssss";
    final instance = FirebaseFirestore.instance;
    return instance.collection("users").doc(user.uid).set(user.toJson());
  }

  static Future loadUser() async {
    String uid = (await Prefs.loadUserId())!;
    final instance = FirebaseFirestore.instance;
    var val = await instance.collection("users").doc(uid).get();
    return MyUser.fromJson(val.data()!);
  }

  static Future updateUser(MyUser user) async {
    user.uid = (await Prefs.loadUserId())!;
    final instance = FirebaseFirestore.instance;
    return instance.collection("users").doc(user.uid).update(user.toJson());
  }

  static Future<List<MyUser>> searchUser(String key) async {
    var uid = await Prefs.loadUserId();
    List<MyUser> users = [];
    final instance = FirebaseFirestore.instance;
    var snapshot = await instance.collection("users").orderBy("username").startAt([key]).get();
    // var snapshot = await instance.collection("users").get();
    for (var element in snapshot.docs) {
      MyUser user = MyUser.fromJson(element.data());
      if(user.uid != uid){
        users.add(user);
      }
    }
    return users;
  }


}