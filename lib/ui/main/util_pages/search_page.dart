import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
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
                itemCount: 20,
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
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                    'uzcoderr',
                                  style: TextStyle(
                                    fontSize: 19
                                  ),
                                ),
                                Text(
                                    'Azizbek Xoliqov',
                                  style: TextStyle(
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
