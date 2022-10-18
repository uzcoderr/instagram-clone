import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/User.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';

import '../../../models/post_model.dart';

class DataService {
  static final instance = FirebaseFirestore.instance;

  // ignore: constant_identifier_names
  static const String folder_user = "users";
  // ignore: constant_identifier_names
  static const String folder_posts = "posts";
  // ignore: constant_identifier_names
  static const String folder_feeds = "feeds";
  // ignore: non_constant_identifier_names
  static String get folder_following => "following";

  // ignore: non_constant_identifier_names
  static String get folder_followers => "followers";

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
    var snapshot = await instance
        .collection("users")
        .orderBy("username")
        .startAt([key]).get();
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

    await instance
        .collection(folder_user)
        .doc(user.uid)
        .collection(folder_posts)
        .doc(posId)
        .set(post.toJson());
    return post;
  }

  static Future<Post> storeFeet(Post post) async {
    final instance = FirebaseFirestore.instance;
    String? uid = await Prefs.loadUserId();

    await instance
        .collection(folder_user)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String? uid = await Prefs.loadUserId();
    final instance = FirebaseFirestore.instance;

    var query = await instance
        .collection(folder_user)
        .doc(uid)
        .collection(folder_feeds)
        .get();

    for (var element in query.docs) {
      Post post = Post.fromJson(element.data());
      posts.add(post);
    }
    return posts;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String? uid = await Prefs.loadUserId();

    var query = await instance
        .collection(folder_user)
        .doc(uid)
        .collection(folder_posts)
        .get();

    for (var element in query.docs) {
      Post post = Post.fromJson(element.data());
      posts.add(post);
    }
    return posts;
  }

  static Future<Post> likePost(Post post, bool liked) async {
    String? uid = await Prefs.loadUserId();
    post.liked = liked;

    await instance
        .collection(folder_user)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());

    if (uid == post.uid) {
      await instance
          .collection(folder_user)
          .doc(uid)
          .collection(folder_posts)
          .doc(post.id)
          .set(post.toJson());
    }

    return post;
  }



  // Follower and Following Related

  static Future<MyUser> followUser(MyUser someone) async {
    MyUser me = await loadUser();

    // I followed to someone
    await instance.collection(folder_user).doc(me.uid).collection(folder_following).doc(someone.uid).set(someone.toJson());

    // I am in someone`s followers
    await instance.collection(folder_user).doc(someone.uid).collection(folder_followers).doc(me.uid).set(me.toJson());

    return someone;
  }

  static Future<MyUser> unfollowUser(MyUser someone) async {
    MyUser me = await loadUser();

    // I un followed to someone
    await instance.collection(folder_user).doc(me.uid).collection(folder_following).doc(someone.uid).delete();

    // I am not in someone`s followers
    await instance.collection(folder_user).doc(someone.uid).collection(folder_followers).doc(me.uid).delete();

    return someone;
  }

  static Future storePostsToMyFeed(MyUser someone) async{
    // Store someone`s posts to my feed

    List<Post> posts = [];
    var querySnapshot = await instance.collection(folder_user).doc(someone.uid).collection(folder_posts).get();
    querySnapshot.docs.forEach((result) {
      var post = Post.fromJson(result.data());
      post.liked = false;
      posts.add(post);
    });

    for(Post post in posts){
      storeFeet(post);
    }
  }

  static Future removePostsFromMyFeed(MyUser someone) async{
    // Remove someone`s posts from my feed

    List<Post> posts = [];
    var querySnapshot = await instance.collection(folder_user).doc(someone.uid).collection(folder_posts).get();
    querySnapshot.docs.forEach((result) {
      posts.add(Post.fromJson(result.data()));
    });

    for(Post post in posts){
      removeFeed(post);
    }
  }

  static Future removeFeed(Post post) async{
    String? uid = await Prefs.loadUserId();

    return await instance.collection(folder_user).doc(uid).collection(folder_feeds).doc(post.id).delete();
  }

  static Future removePost(Post post) async{
    String? uid = await Prefs.loadUserId();
    await removeFeed(post);
    return await instance.collection(folder_user).doc(uid)
        .collection(folder_posts).doc(post.id).delete();
  }

}
