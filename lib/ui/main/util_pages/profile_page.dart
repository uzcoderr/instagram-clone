import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/service/network/firebase/firestore.dart';
import 'package:instagram/service/network/firebase/upload_post_profile_photo.dart';

import '../../../models/User.dart';
import '../../../models/post_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String username = "username", fullName = "Full Name", userImg = "assets/image/img.jpg", followers = "0", following = "0";

  List<Post> posts = [];

  loadPosts(){
    DataService.loadPosts().then((value) => {
      setData(value)
    });
  }

  setData(List<Post> postsList){
    setState(() {
      posts = postsList;
    });
  }

  _actionRemovePost(Post post,bool result) async{
    if(result != null && result){
      DataService.removePost(post).then((value) => {
        loadPosts(),
      });
    }
  }

  loadUser(){
    loadPosts();
    DataService.loadUser().then((value) => {
      setState((){
        username = value.username;
        fullName = value.fullName;
        userImg = value.imageUrl;
        followers = value.followers;
        following = value.following;
      })
    });
  }

  bool uploadIngImage = false;

  void pickImage() async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    MyUser user = await DataService.loadUser();
    if(image != null){
      setState(() {
        uploadIngImage = true;
      });
    }
    FileService.uploadUserImage(image!).then((value) => {
      user.imageUrl = value,
      updateUser(user),
    });

  }

  updateUser(MyUser user) async{
    await DataService.updateUser(user);
    setState((){
      userImg = user.imageUrl;
      setState(() {
        uploadIngImage = false;
      });
    });
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: const [
          Icon(Icons.add_box_outlined,size: 30,),
          SizedBox(width: 10,),
          Icon(Icons.menu,size: 30,),
          SizedBox(width: 10,)
        ],
        leadingWidth: 0,
        leading: Container(),
        backgroundColor: Colors.black,
        title: Text(
            username,
          style: const TextStyle(
            fontSize: 24
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.white70,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(193, 53, 132, 1),
                          Color.fromRGBO(131, 58, 180, 1),
                    ])
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          pickImage();
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: NetworkImage(userImg)
                            )
                          ),
                        ),
                      ),
                      uploadIngImage ? const Center(
                        child: CircularProgressIndicator(),
                      ) : Container()
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child:
                              Column(
                               children: [
                                  Text(
                                      posts.length.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                 const SizedBox(
                                   height: 5,
                                 ),
                                 const Text(
                                   'Posts',
                                   style: TextStyle(
                                       color: Colors.white70
                                   ),
                                 )
                                ],
                              )
                        ),
                        Expanded(
                            child:
                            Column(
                              children: [
                                Text(
                                  followers,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: Colors.white70
                                  ),
                                )
                              ],
                            )
                        ),
                        Expanded(
                            child:
                            Column(
                              children: [
                                Text(
                                  following,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                    'Following',
                                  style: TextStyle(
                                    color: Colors.white70
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15,top: 10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
                fullName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15,top: 5,right: 5),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20,left: 15,right: 15),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white70
              )
            ),
            child: const Text(
                'Edit Profile',
              style: TextStyle(
                fontSize: 18
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: const [
              Expanded(
                  child: Center(
                    child: Icon(Icons.grid_on),
                  )
              ),
              Expanded(
                  child: Center(
                    child: Icon(Icons.supervised_user_circle_outlined),
                  )
              ),
            ],
          ),
          const Divider(),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return CupertinoContextMenu(
                      actions: [
                        CupertinoContextMenuAction(
                          onPressed: () {
                            _actionRemovePost(posts[index], true);
                          },
                            child: const Text('Remove')
                        ),
                        const CupertinoContextMenuAction(
                            child: Text('Like')
                        ),
                      ],
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue
                        ),
                        child: Expanded(
                            child: Image.network(
                              fit: BoxFit.cover,
                              posts[index].img_post
                            )
                        ),
                      ),
                    );
                  },
              )
          )
        ],
      ),
    );
  }
}
