import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  //const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _email1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  //child 1
                  Container(
                    child: Image(image: AssetImage('images/message.jpeg') ,),
                    width: 300,
                    height: 250,
                  ),

                  //child 2
                  Column(
                    children: [
                      //Email Formfield
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(10.0),),
                          child: TextFormField(
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'Enter your email',
                                icon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(32.0)))
                            ),
                            controller: _email1,
                            validator: (value) {
                              if (value!.contains('*') || value.contains('#') || value.isEmpty || ! value.contains('@')) {
                                return 'Please a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      //Password formfield
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            //color: Colors.pink[200],
                            borderRadius: new BorderRadius.circular(10.0),),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Enter your password',
                                icon: Icon(Icons.vpn_key),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(32.0)))
                            ),
                            controller: _pass1,
                            validator: (value) {
                              if (value!.length < 6 || value.isEmpty ) {
                                return 'Password has to be at least six characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  //child 3
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.symmetric( horizontal: 60)
                        ),
                        onPressed: () {
                          saveData( _email1.text, _pass1.text);
                          print('data saved');
                        },
                        child: Text('Login'),

                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
      );
    }

    Future<void> saveData(String email, String password) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
      print('${prefs.get('password')}');
    }
}