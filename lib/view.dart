import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messages_value/message.dart';
import 'package:messages_value/messageDB.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  late List<SingleMessage> messages;
  bool isLoading= false;
  bool _isLoggedIn = true;
  String subtitle='';

  void initState() {
    super.initState();
    refreshMessages();
  }


  // void dispose() {
  //   MessagesDataBase.instance.close();
  //   super.dispose();
  // }

  Future refreshMessages() async {
    setState(() => isLoading = true);
    this.messages = await MessagesDataBase.instance.readAllMessages();
    setState(() => isLoading = false);
  }

  String encode(String? message){
    assert(message != null);
    return base64.encode(utf8.encode(message!));
  }

  String decode(String encoded){
    return utf8.decode(base64.decode(encoded));
  }

  void setIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final password = prefs.get('password');
    _isLoggedIn =  (password!= null);
  }

  @override
  Widget build(BuildContext context) {

      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            isLoading
              ? CircularProgressIndicator()
              : messages.isEmpty
              ? Text(
            'No Notes',
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
              : buildMessages(),

            IconButton(
              icon: Icon(Icons.vpn_key),
              onPressed: () async{
                setIsLoggedIn();
                setState(() {
                  if (_isLoggedIn) {
                    setState(() {
                      subtitle = decode(subtitle);
                    });
                    print('logged in');
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Private: you are not logged in.'),
                      ),
                    );
                  }
                }
                );
              },
            ),

            FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.refresh),
              onPressed: () async {
                refreshMessages();
              },
            ),
          ]
        ),
      );
    }

    Widget buildMessages(){
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          subtitle = encode(message.text);
          return ListTile(
              leading: Icon(Icons.message),
              title: Text('Message $index '),
              subtitle: Text(subtitle),
          );
        },
      );
  }


}