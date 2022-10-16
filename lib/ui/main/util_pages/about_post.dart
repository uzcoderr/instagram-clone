import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AboutPost extends StatefulWidget {
  String image;
  AboutPost({required this.image, Key? key}) : super(key: key);

  @override
  State<AboutPost> createState() => _AboutPostState();
}

class _AboutPostState extends State<AboutPost> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('New Post'),
        actions: const [
          Icon(
              Icons.check,
            color: Colors.blue,
          ),
          SizedBox(width: 15,)
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
                  child: Image.file(
                      fit: BoxFit.cover ,
                      File(widget.image)
                  ),
                ),
                const SizedBox(width: 15,),
                const Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write post',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
