import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram/ui/main/util_pages/about_post.dart';
import 'package:photo_manager/photo_manager.dart';

class Poster extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const Poster({this.cameras,Key? key}) : super(key: key);

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {

  List<AssetEntity> assets = [];

  List<File> images = [];

  var selectedImage = 0;

  late CameraController controller;

  XFile? pictureFile;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      cameraController.description;
    }
  }

  var camIndex = 0;

  @override
  void initState() {
    PhotoManager.requestPermissionExtend();
    _fetchAssets();
    loadImg();
    startCamera();
    super.initState();
  }

  void startCamera(){
    controller = CameraController(
        widget.cameras![camIndex],
        ResolutionPreset.max,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 150, // end at a very big index (to get all the assets)
    );

    setState(() => assets = recentAssets);
  }

  Future loadImg() async {
    images = [];
    try {
      for (int i = 0; i < assets.length; i++) {
        assets[i].file.then((value) => {
          setState(() {
            if(value!.path.endsWith('.jpg') || value.path.endsWith('.jpg')){
              images.add(value);
            }
          })
        });
      }
    } catch (e) {
      print('Azizbek');
    }
  }

  XFile? pic;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Post'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (){
            setState(() {
              loadImg();
            });
          },
          child: const Icon(
            color: Colors.blue,
            Icons.change_circle
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: CameraPreview(controller)
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.small(
                                    onPressed: (){
                                      camIndex = 2;
                                      startCamera();
                                    },
                                  backgroundColor: Colors.white54,
                                  child: const Text('0.5x'),
                                ),
                                FloatingActionButton.small(
                                  onPressed: (){
                                    camIndex = 0;
                                    startCamera();
                                  },
                                  backgroundColor: Colors.white54,
                                  child: const Text('1x'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                  backgroundColor: Colors.black,
                                  onPressed: () async{
                                    await controller.takePicture().then((value) => {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPost(image: value.path)))
                                    });
                                    setState(() {});
                                    // await controller.takePicture();
                                  },
                                  child: const Icon(
                                    Icons.camera,
                                    color: Colors.blue,
                                  )
                              ),
                              const SizedBox(width: 10,),
                              FloatingActionButton(
                                  backgroundColor: Colors.black,
                                  onPressed: (){
                                    camIndex = camIndex == 1 ? 0 : 1;
                                    startCamera();
                                    // await controller.takePicture();
                                  },
                                  child: const Icon(
                                    Icons.camera_front,
                                    color: Colors.blue,
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                child: pic != null ? Image.file(File(pic!.path)): Container(),
              ),
              Expanded(
                child: GridView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPost(image: images[index].path,)));
                              // camIndex = camIndex == 1 ? 0 : 1;
                              // startCamera();
                          },
                          child: Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent
                                ),
                                // ignore: unnecessary_null_comparison
                                child: images[index] != null ?
                                Image.file(
                                    fit: BoxFit.cover,
                                    File(images[index].path),
                                ) : Container()
                                ,)),
                        );
                      },
                      itemCount: images.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                    ),
              ),
            ],
          ),
        ),
      );
  }
}
