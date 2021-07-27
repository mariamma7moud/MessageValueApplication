import 'package:localstorage/localstorage.dart';

import 'package:flutter/material.dart';
import 'package:messages_value/home.dart';
import 'package:messages_value/view.dart';
import 'package:messages_value/write.dart';


class MyApp extends StatefulWidget {
  //const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex= 0;
  List<Text> title=[
    Text('Send Message'),
    Text('Home'),
    Text('View Messages')
  ];
  List<Widget> screens= [Write(), Home(), View()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messages Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: title[_currentIndex],
        ),
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          backgroundColor: Colors.blueAccent,
          selectedIconTheme: IconThemeData(color: Colors.black),
          selectedItemColor: Colors.black,
          iconSize: 50,
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Send Message'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: 'View Messages'
            ),
          ],
        ),

      ),

    );
  }
}

