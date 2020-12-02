import 'package:chat_app/views/chatRoomsScreens.dart';
import 'package:chat_app/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/views/signin.dart';

import 'helper/authenticate.dart';
import 'helper/helperfunctions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()

          : Container(

        child: Center(

          child: Authenticate(),

        ),

      ),

    );
  }
}





