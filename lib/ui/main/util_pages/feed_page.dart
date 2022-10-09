import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';
import 'package:instagram/service/network/firebase/auth.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
              FontAwesomeIcons.facebookMessenger,
          ),
          SizedBox(width: 15,)
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            AuthService.signOutUser(context);
          },
            child: const Icon(Icons.camera_alt_outlined)),
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Billabong'
          ),
        ),
      ),
      body:
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/image/img.jpg'),
                          ),
                          const SizedBox(width: 7,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'uzcoderr',
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  ),
                                  const SizedBox(width: 3,),
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
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/image/img.jpg')
                                    )
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                                'assets/image/img.jpg'
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7,top: 5),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(FontAwesomeIcons.heart),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(FontAwesomeIcons.comment),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(FontAwesomeIcons.paperPlane),
                          ),
                          Expanded(child: Center()),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(FontAwesomeIcons.bookmark),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 15,top: 5),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: const Text(
                          '100 Likes',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0,left: 15),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('username',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 17.0,top: 3),
                      child: Text(
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          'asdhja skhalkhlfkjsd hlfkjhsd jhsldfk jlhskjdahfas asdh lkafakjshdfklj shdfkj lhaskhf ashdlkasj llkjaslf;jdslkjf '
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            backgroundImage: NetworkImage('https://images.pexels.com/photos/302743/pexels-photo-302743.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Add comments ...',
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('Post',style: TextStyle(color: Colors.blue),),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
            },),
    );
  }
}
