import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreens.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn(BuildContext context){
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

      databaseMethods.getUserByUserEmail(emailTextEditingController.text)
          .then((val){
        snapshotUserInfo = val;
        HelperFunctions
            .saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
      });



      setState(() {
        isLoading = true;
      });



      
      authMethods.signInWithEmailAndPassword(
          emailTextEditingController.text,
          passwordTextEditingController.text).then((val){
            if(val !=null){

              HelperFunctions.saveUserLoggedInSharedPreference(true);

              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>ChatRoom()
              ));
            }else{
              _showDialog(context);
            }

      });



    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               Form(
                 key: formKey,
                 child: Column(
                   children: <Widget>[
                     TextFormField(
                       controller: emailTextEditingController,
                       validator: (val){
                         return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?

                         null : "Eplease provide a valid email id";
                       },
                       style: simpleTextStyle(),
                       decoration: textFieldInputDecoration("email"),
                     ),
                     TextFormField(
                       obscureText: true,
                       validator: (val){
                         return  val.length>6 ? null : "Please Provide password 6+ characters";
                       },
                       controller: passwordTextEditingController,
                       style: simpleTextStyle(),
                       decoration: textFieldInputDecoration("password2"),
                     ),
                   ],
                 ),
               ),

                SizedBox(
                  height: 8,
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "forgot Password",
                      style: simpleTextStyle(),
                    ),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                GestureDetector(
                  onTap: (){
                    signIn(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xff007EF4),
                            Color(0xff2A75BC)
                          ],

                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                        "Sign In",
                      style: mediumTextStyle(),
                    ),

                  ),
                ),


                SizedBox(
                  height: 16,
                ),





                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),
                  ),

                ),


                SizedBox(
                  height: 16,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "Don't have account? ",
                      style: mediumTextStyle(),
                    ),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50,
                ),

              ],
            ),

          ),
        ),
      ),

    );
  }
}

void _showDialog(BuildContext context) {

  // flutter defined function

  showDialog(

    context: context,

    builder: (BuildContext context) {

      // return object of type Dialog

      return AlertDialog(

        title: new Text("Invalid User"),

        content: new Text("Email or Password is incorrect!"),

        actions: <Widget>[

          // usually buttons at the bottom of the dialog

          new FlatButton(

            child: new Text("Close"),

            onPressed: () {

              Navigator.of(context).pop();

            },

          ),

        ],

      );

    },

  );

}