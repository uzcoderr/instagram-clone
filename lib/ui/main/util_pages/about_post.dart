import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/service/network/firebase/firestore.dart';
import 'package:instagram/service/network/firebase/upload_post_profile_photo.dart';
import 'package:instagram/ui/main/util_pages/home_page.dart';

// ignore: must_be_immutable
class AboutPost extends StatefulWidget {
  String image;

  AboutPost({required this.image, Key? key}) : super(key: key);

  @override
  State<AboutPost> createState() => _AboutPostState();
}

class _AboutPostState extends State<AboutPost> {
  TextEditingController caption = TextEditingController();

  bool isLoading = false;

  storePost() async{
    await FileService.uploadPostImage(File(widget.image))
        .then((value) => {store(value)});
  }

  store(String img_url) async{
    Post post = Post(img_post: img_url, caption: caption.text.trim());
    await DataService.storePost(post).then((value) => {
      DataService.storeFeet(value).then((value) => {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()))
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('New Post'),
            actions: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isLoading = true;
                  });
                  storePost();
                },
                child: const Icon(
                  Icons.check,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.file(fit: BoxFit.cover, File(widget.image)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: caption,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Write post',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        isLoading ? Container(
          decoration: const BoxDecoration(
            color: Colors.black87
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ) : const Center()
      ],
    );
  }
}
