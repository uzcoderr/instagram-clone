class Post {
  String uid = "";
  String fullName = "";
  String img_user = "";
  String img_post = "";
  String caption = "";
  String date = "";
  bool liked = false;

  bool mine = false;

  Post({required this.uid,
    required this.fullName,
    required this.img_user,
    required this.img_post,
    required this.caption,
    required this.date,
    required this.liked,
    required this.mine});

  Post.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        fullName = json["fullName"],
        img_user = json["img_user"],
        img_post = json["img_post"],
        caption = json["caption"],
        date = json["date"],
        liked = json["liked"],
        mine = json["mine"];

  Map<String,dynamic> toJson() => {
    'uid': uid,
    'fullName': fullName,
    'img_user': img_user,
    'img_post': img_post,
    'caption': caption,
    'date': date,
    'liked': liked,
    'mine': mine,
  };

}
