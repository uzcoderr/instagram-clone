
class User {
  String uid = "";
  String fullName = "";
  String email = "";
  String password = "";
  String imageUrl = "";

  bool followed = false;
  int followers = 0;
  int following = 0;

  User({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.followed,
    required this.followers,
    required this.following,
  });

  User.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        fullName = json["fullName"],
        email = json["email"],
        password = json["password"],
        imageUrl = json["imageUrl"],
        followed = json["followed"],
        followers = json["followers"],
        following = json["following"];


  Map<String, dynamic> toJson() => {
    'uid': uid,
    'fullName': fullName,
    'email': email,
    'password': password,
    'imageUrl': imageUrl,
    'followed': followed,
    'followers': followers,
    'following': following,
  };

  @override
  bool operator ==(other) {
    return (other is User) && other.uid == uid;
  }
}
