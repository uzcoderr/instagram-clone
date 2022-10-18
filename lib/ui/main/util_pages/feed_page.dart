import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/service/network/firebase/auth.dart';
import 'package:instagram/service/network/firebase/firestore.dart';
import 'package:palette_generator/palette_generator.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Post> posts = [];

  bool isLoading = false;

  loadFeed() {
    setState(() {
      isLoading = true;
    });
    DataService.loadFeeds().then((value) => {setData(value)});
  }

  setData(List<Post> listPosts) {
    setState(() {
      isLoading = false;
      posts = listPosts;
    });
  }

  likedClick(Post post) async {
    DataService.likePost(post, true).then((value) => {
          setState(() {
            post.liked = true;
          })
        });
  }

  unLikedClick(Post post) async {
    DataService.likePost(post, false).then((value) => {
          setState(() {
            post.liked = false;
          })
        });
  }

  @override
  void initState() {
    loadFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            FontAwesomeIcons.facebookMessenger,
          ),
          SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              AuthService.signOutUser(context);
            },
            child: const Icon(Icons.camera_alt_outlined)),
        title: const Text(
          'Instagram',
          style: TextStyle(fontSize: 30, fontFamily: 'Billabong'),
        ),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(posts[index].img_user),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                posts[index].fullName,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.verified,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      const Icon(Icons.more_horiz)
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width,
                        child: Blur(
                          blur: 17.5,
                          blurColor: Colors.white,
                          child: GestureDetector(
                            onDoubleTap: () {
                              if (posts[index].liked) {
                                unLikedClick(posts[index]);
                              } else {
                                likedClick(posts[index]);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(posts[index].img_post))),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onDoubleTap: () {
                            if (posts[index].liked) {
                              unLikedClick(posts[index]);
                            } else {
                              likedClick(posts[index]);
                            }
                          },
                          child: Image.network(posts[index].img_post),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7, top: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (posts[index].liked) {
                            unLikedClick(posts[index]);
                          } else {
                            likedClick(posts[index]);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: posts[index].liked
                              ? const Icon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.red,
                                )
                              : const Icon(FontAwesomeIcons.heart),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Transform.rotate(
                            angle: 5.5, child: const Icon(Icons.send)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.share),
                      ),
                      const Expanded(child: Center()),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.bookmark),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: const Text(
                      '100 Likes',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 15),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0, top: 3),
                  child: Text(
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      posts[index].caption),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/302743/pexels-photo-302743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Add comments ...',
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Post',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
