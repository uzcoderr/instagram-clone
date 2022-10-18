import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';

class FileService{

  static final storage = FirebaseStorage.instance.ref();
  // ignore: constant_identifier_names
  static const folder_posts = "folder_posts";
  // ignore: constant_identifier_names
  static const folder_user_image = "folder_posts";

  static Future<String> uploadUserImage(XFile file) async{
    String? uid = await Prefs.loadUserId();
    var image_name = uid!;
    var firebaseStorageRef = storage.child(folder_user_image).child(image_name);
    UploadTask uploadTask = firebaseStorageRef.putFile(File(file.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  static Future<String> uploadPostImage(File file) async{
    String? uid = await Prefs.loadUserId();
    var imageName = "${uid!}${DateTime.now()}";
    var firebaseStorageRef = storage.child(folder_posts).child(imageName);
    UploadTask uploadTask = firebaseStorageRef.putFile(File(file.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  static Future<List> CompressAndGetFile(List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list as Uint8List,
      quality: 88,
    );
    return result;
  }


}