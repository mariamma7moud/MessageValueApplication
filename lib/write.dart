import 'package:flutter/material.dart';
import 'package:messages_value/message.dart';
import 'package:messages_value/messageDB.dart';
import 'package:messages_value/myApp.dart';

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class Write extends StatefulWidget {
  final SingleMessage? message;
  const Write({
    Key? key,
    this.message,
  }): super(key:key);

  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final _formKey = GlobalKey<FormState>();
  late String text;
  late int id;
  static int countID=0;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: messageController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: 'Enter your message',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)))
              ),
            ),
            ElevatedButton(onPressed:()async{
              addMessage();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Message Sent'),
                ),
              );
            }, child: Text('Send'))
          ],
        ),
      )
    );
  }

  Future addMessage() async {
    final message = SingleMessage(
        id: countID, text: messageController.text
    );
    await MessagesDataBase.instance.createMessage(message);
    print('message added to db');
  }
}
