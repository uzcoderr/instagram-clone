import 'package:flutter/material.dart';
import 'package:instagram/models/User.dart';
import 'package:instagram/service/network/firebase/firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<MyUser> users = [];
  TextEditingController search = TextEditingController();

  searchUsers(String s){
    DataService.searchUser(s).then((value) => {
      setState((){
        users = value;
      })
    });
  }

  @override
  void initState() {
    searchUsers(search.text.trim());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(Icons.circle,color: Colors.black,),
        centerTitle: true,
        title: const Text(
            'Search',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Billabong'
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(right: 20,left: 20,top: 15),
            padding: const EdgeInsets.only(right: 5,left: 10),
            decoration: BoxDecoration(
                color: Colors.white54.withOpacity(0.2),
                borderRadius: BorderRadius.circular(7)
            ),
            child: TextField(
              onChanged: (value){
                searchUsers(value);
              },
              controller: search,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: 'Search',
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54)
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 80,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(193, 53, 132, 1),
                                    Color.fromRGBO(131, 58, 180, 1),
                                  ]),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image/def.png')
                                )
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                    image: NetworkImage(users[index].imageUrl)
                                )
                              ),
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    users[index].username,
                                  style: const TextStyle(
                                    fontSize: 19
                                  ),
                                ),
                                Text(
                                    users[index].fullName,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 7,bottom: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.white
                            )
                          ),
                          child: const Text('Follow'),
                        )
                      ],
                    ),
                  ),
                );
          },))
        ],
      )
    );
  }
}
