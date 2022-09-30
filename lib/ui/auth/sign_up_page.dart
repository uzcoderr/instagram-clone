import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(193, 53, 132, 1),
                  Color.fromRGBO(131, 58, 180, 1),
                ])),
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Instagram',
                          style: TextStyle(fontFamily: 'Billabong', color: Colors.white,fontSize: 50),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(right: 30,left: 30),
                          padding: const EdgeInsets.only(right: 5,left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white54)
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(right: 30,left: 30),
                          padding: const EdgeInsets.only(right: 5,left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Full Name',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white54)
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(right: 30,left: 30),
                          padding: const EdgeInsets.only(right: 5,left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Username',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white54)
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(right: 30,left: 30),
                          padding: const EdgeInsets.only(right: 5,left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white54)
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(right: 30,left: 30),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white54
                                ),
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                        ),
                      ],
                    )
                )),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do you have an account ?' ,style: TextStyle(color: Colors.white70),),
                    const SizedBox(width: 5,),
                    GestureDetector(
                        onTap: (){
                            Navigator.pop(context);
                        },
                        child: const Text(
                          'SignIn',style: TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.white),
                        )
                    )
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
