import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:messages_value/message.dart';
import 'package:messages_value/messageDB.dart';
import 'package:messages_value/myApp.dart';

class View extends StatefulWidget {

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  late List<SingleMessage> messages;
  bool isLoading = false;

  void initState(){
    super.initState();
    refreshMessages();
  }
  
  void dispose(){
    MessagesDataBase.instance.close();
    super.dispose();
  }
  
  Future refreshMessages() async{
    setState(() => isLoading = true);
    this.messages = await MessagesDataBase.instance.readAllMessages();
    setState(()=> isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoading
          ? CircularProgressIndicator()
          : messages.isEmpty
          ? Text(
        'No Notes',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildMessages(),

        FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            //await Navigator.of(context).push(
              //MaterialPageRoute(builder: (context) => AddEditNotePage()),
            //);
            refreshMessages();
          },
        ),
      ]
    );
  }

  Widget buildMessages(){
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
            leading: Icon(Icons.message),
            title: Text('$index message'),
            subtitle: Text('${message.text}'),
            trailing: IconButton(
              icon: Icon(Icons.vpn_key),
              onPressed: () {
                setState(() {
                  // if( loggedin ){
                  //   setState(() {
                  //     _messageSubtitleText= decrypt( _messageSubtitleText);
                  //   });
                  //
                  // }else{
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Private: you are not logged in.'),
                    ),
                  );
                  // }
                  //if logged in
                  //Replace encrypted String

                  //if not logged in
                  //show error message
                });
              },
            )
        );
      },
    );
  }


  

  // static int countID=0;
  // bool loggedin = true;
  // String _messageSubtitleText = 'place here the message the user sent but decrypted!';
  //
  //
  // //create and add message
  // _addMessage(String text) {
  //   setState(() {
  //     final messageItem = new SingleMessage(text: text, id:++countID );
  //     list.messageList.add(messageItem);
  //     _saveToStorage();
  //   });
  // }
  //
  // _saveToStorage() {
  //   storage.setItem('message', list.toJSONEncodable());
  // }
  //
  // String decrypt( String s){
  //   String decrypted = 'this is the decrypted message ';
  //   //do decryption here
  //   return decrypted;
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return ListView.separated(
  //     itemCount: 10, //add here messageList.length
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: Icon(Icons.message),
  //         trailing: IconButton(
  //           icon: Icon(Icons.vpn_key),
  //           onPressed: (){
  //             setState(() {
  //               if( loggedin ){
  //                 setState(() {
  //                   _messageSubtitleText= decrypt( _messageSubtitleText);
  //                 });
  //
  //               }else{
  //                 Scaffold.of(context).showSnackBar(
  //                   SnackBar(
  //                     duration: Duration(seconds: 2),
  //                     content: Text('Private: you are not logged in.'),
  //                   ),
  //                 );
  //               }
  //               //if logged in
  //               //Replace encrypted String
  //
  //               //if not logged in
  //               //show error message
  //             });
  //           },
  //         ),
  //         title: Text('$index message'),
  //         subtitle: Text(_messageSubtitleText),
  //       );
  //     },
  //     separatorBuilder: (context, index) {
  //       return Divider();
  //     },
  //   );
  // }
}
