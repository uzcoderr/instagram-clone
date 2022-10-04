import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/ui/main/util_pages/feed_page.dart';
import 'package:instagram/ui/main/util_pages/likes_page.dart';
import 'package:instagram/ui/main/util_pages/profile_page.dart';
import 'package:instagram/ui/main/util_pages/search_page.dart';
import 'package:instagram/ui/main/util_pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var screens = [
    const FeedPage(),
    const SearchPage(),
    const UploadPost(),
    const LikesPage(),
    const ProfilePage()
  ];
  int index = 0;


  Widget bottomNav(){
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: const Color.fromRGBO(131, 58, 180, 1),
      strokeColor: const Color.fromRGBO(131, 58, 180, 1),
      unSelectedColor: const Color(0xffacacac),
      backgroundColor: Colors.black,
      items: [
        CustomNavigationBarItem(
          icon: const Icon(
            FontAwesomeIcons.house,
            size: 23,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 23,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            FontAwesomeIcons.circlePlus,
            size: 23,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            FontAwesomeIcons.heart,
            size: 23,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            FontAwesomeIcons.circleUser,
            size: 23,
          ),
        ),
      ],
      currentIndex: index,
      onTap: (ex) {
        setState(() {
          index = ex;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: bottomNav(),
    );

  }
}
