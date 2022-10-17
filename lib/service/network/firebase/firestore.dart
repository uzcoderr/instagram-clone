import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/User.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';

import '../../../models/post_model.dart';

class DataService {

  // ignore: constant_identifier_names
  static const String folder_user = "users";
  static const String folder_posts = "posts";
  static const String folder_feeds = "feeds";

  static Future storeUser(MyUser user) async {
    user.uid = (await Prefs.loadUserId())!;
    final instance = FirebaseFirestore.instance;
    return instance.collection(folder_user).doc(user.uid).set(user.toJson());
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
    var snapshot = await instance.collection("users")
        .orderBy("username")
        .startAt([key])
        .get();
    // var snapshot = await instance.collection("users").get();
    for (var element in snapshot.docs) {
      MyUser user = MyUser.fromJson(element.data());
      if (user.uid != uid) {
        users.add(user);
      }
    }
    return users;
  }

  static Future<Post> storePost(Post post) async {
    final instance = FirebaseFirestore.instance;
    MyUser user = await loadUser();
    post.img_user = user.imageUrl;
    post.fullName = user.fullName;
    post.uid = user.uid;
    post.date = DateTime.now().toString();

    String posId = instance
        .collection(folder_user)
        .doc(user.uid)
        .collection(folder_posts)
        .doc()
        .id;
    post.id = posId;

    await instance.collection(folder_user).doc(user.uid).collection(folder_posts).doc(posId).set(post.toJson());
    return post;
  }

  static Future<Post> storeFeet(Post post) async{
    final instance = FirebaseFirestore.instance;
    String? uid = await Prefs.loadUserId();
    
    await instance.collection(folder_user).doc(uid).collection(folder_feeds).doc(post.id).set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadFeeds() async{
    List<Post> posts = [];
    String? uid = await Prefs.loadUserId();
    final instance = FirebaseFirestore.instance;

    var query = await instance.collection(folder_user).doc(uid).collection(folder_feeds).get();

    for (var element in query.docs) {
      Post post = Post.fromJson(element.data());
      posts.add(post);
    }
    return posts;
  }

}