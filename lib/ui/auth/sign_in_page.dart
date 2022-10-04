import 'package:flutter/material.dart';
import 'package:instagram/ui/auth/sign_up_page.dart';
import 'package:instagram/ui/main/util_pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                              hintText: 'Password',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white54)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
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
                                'Sign In',
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
                  const Text('Don\'t have an account ?' ,style: TextStyle(color: Colors.white70),),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpPage()));
                    },
                      child: const Text(
                        'SignUp',style: TextStyle(
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
