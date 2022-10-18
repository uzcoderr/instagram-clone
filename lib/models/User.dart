class MyUser {
  String uid = "";
  String fullName = "";
  String username = "";
  String email = "";
  String password = "";
  String imageUrl = "";

  String device_id = "";
  String device_type = "";
  String device_token = "";

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
        device_id = json['device_id'],
        device_type = json['device_type'],
        device_token = json['device_token'],
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
        'device_id': device_id,
        'device_type': device_type,
        'device_token': device_token,
      };

  @override
  bool operator ==(other) {
    return (other is MyUser) && other.uid == uid;
  }
}
