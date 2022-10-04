import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram/ui/main/util_pages/upload_post.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {

  List<AssetEntity> assets = [];

  List<File> images = [];

  @override
  void initState() {
    PhotoManager.requestPermissionExtend();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Center(
            child: ElevatedButton(
              onPressed: () async{
                await availableCameras().then((value) => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Poster(cameras: value),))
                });
              },
              child: const Text('Upload'),
            ),
          ),
    );
  }
}
