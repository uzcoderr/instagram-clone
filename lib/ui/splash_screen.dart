import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram/service/local/shared_pref/auth.dart';
import 'package:instagram/ui/auth/sign_in_page.dart';
import 'package:instagram/ui/main/util_pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _initTimer(){
    Timer(const Duration(seconds: 2),(){
      _callSignInPage();
    });
  }

  _callSignInPage(){
    Widget widget = const SignInPage();
    Prefs.loadUserId().then((value) => {
      if(value!.isNotEmpty){
        widget = const HomePage()
      }
    });


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> widget));
  }

  @override
  void initState() {
    _initTimer();
    super.initState();
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
            const Expanded(
                child: Center(
              child: Text(
                'Instagram',
                style: TextStyle(fontFamily: 'Billabong', color: Colors.white,fontSize: 50),
              ),
            )),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: const Text('All rights reserved',style: TextStyle(color: Colors.white70),),
            )
          ],
        ),
      ),
    );
  }
}
