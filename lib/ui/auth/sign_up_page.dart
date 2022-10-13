import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';
import 'package:instagram/service/network/firebase/auth.dart';
import 'package:instagram/service/network/firebase/firestore.dart';
import 'package:instagram/ui/main/util_pages/home_page.dart';

import '../../models/User.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void _signUp(){
    User? user;
    AuthService.signUpUser(context, fullName.text.trim(), email.text.trim(), password.text.trim()).then((value) => {
      // Prefs.saveUserId(value!.uid)
      if(!value.containsKey("SUCCESS")){
        if(value.containsKey("ERROR_EMAIL_ALREADY_IN_USE")){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('ERROR_EMAIL_ALREADY_IN_USE'),
          ),)
        },
        if(value.containsKey("ERROR")){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('ERROR'),
            ),),
        }
      },
      user = value["SUCCESS"],
      Prefs.saveUserId(user!.uid),
      DataService.storeUser(
        MyUser(
            fullName: fullName.text.trim(),
            email: email.text.trim(),
            password: password.text.trim(),
            username: username.text.trim(),
            imageUrl: "",
        )
      ).then((value) => {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()))
      })
    });
  }

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
                          child: TextField(
                            controller: email,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
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
                          child: TextField(
                            controller: fullName,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
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
                          child: TextField(
                            controller: username,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
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
                          child: TextField(
                            controller: password,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white54)
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            _signUp();
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                          },
                          child: Container(
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
