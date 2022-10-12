import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/User.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';

class DataService {

  static Future storeUser(User user) async {
    user.uid = (await Prefs.loadUserId())!;
    final instance = FirebaseFirestore.instance;
    return instance.collection("users").doc(user.uid).set(user.toJson());
  }

  static Future loadUser(User user) async {
    user.uid = (await Prefs.loadUserId())!;
    final instance = FirebaseFirestore.instance;
    var val = await instance.collection("users").doc(user.uid).get();
    return User.fromJson(val.data()!);
  }

  static Future updateUser(User user) async {
    user.uid = (await Prefs.loadUserId())!;
    final instance = FirebaseFirestore.instance;
    return instance.collection("users").doc(user.uid).update(user.toJson());
  }

  static Future<List<User>> searchUser(String key) async {
    List<User> users = [];
    final instance = FirebaseFirestore.instance;
    var snapshot = await instance.collection("users").orderBy("username").startAt([key]).get();
    for (var element in snapshot.docs) {
      users.add(User.fromJson(element.data()));
    }
    return users;
  }

}