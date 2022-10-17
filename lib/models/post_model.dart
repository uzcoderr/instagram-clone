class Post {
  String uid = "";
  String id = "";
  String fullName = "";
  String img_user = "";
  String img_post = "";
  String caption = "";
  String date = "";
  bool liked = false;

  bool mine = false;

  Post({
    required this.img_post,
    required this.caption,});

  Post.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        fullName = json["fullName"],
        id = json["id"],
        img_user = json["img_user"],
        img_post = json["img_post"],
        caption = json["caption"],
        date = json["date"],
        liked = json["liked"],
        mine = json["mine"];

  Map<String,dynamic> toJson() => {
    'uid': uid,
    'fullName': fullName,
    'id': id,
    'img_user': img_user,
    'img_post': img_post,
    'caption': caption,
    'date': date,
    'liked': liked,
    'mine': mine,
  };

}
