import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.white,
                child: Image(
                  image: NetworkImage('https://www.whitehouse.gov/wp-content/uploads/2017/11/President-Trump-Official-Portrait-620x620.jpg'),

                ),
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.red,
                backgroundImage: AssetImage('images/pika.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
