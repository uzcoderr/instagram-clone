class MyUser {
  String uid = "";
  String fullName = "";
  String username = "";
  String email = "";
  String password = "";
  String imageUrl = "";

  bool followed = false;
  String followers = "0";
  String following = "0";

  MyUser({
    // required this.uid,
    required this.fullName,
    required this.email,
    required this.password,
    required this.username,
    required this.imageUrl,
    required this.uid,
    // required this.followed,
    // required this.followers,
    // required this.following,
  });

  MyUser.fromJson(Map<String, dynamic> json)
      // : uid = json["uid"],
      : fullName = json["fullName"],
        imageUrl = json["imageUrl"],
        email = json["email"],
        password = json["password"],
        uid = json["uid"],
        username = json["username"],
        followed = json["followed"],
        followers = json["followers"],
        following = json["following"];

  Map<String, dynamic> toJson() => {
        // 'uid': uid,
        'fullName': fullName,
        'imageUrl': imageUrl,
        'email': email,
        'password': password,
        'username': username,
        'uid': uid,
        'followed': followed,
        'followers': followers,
        'following': following,
      };

  @override
  bool operator ==(other) {
    return (other is MyUser) && other.uid == uid;
  }
}
