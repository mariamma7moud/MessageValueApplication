import 'package:flutter/material.dart';
import 'package:messages_value/myApp.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main()async {
  //Open the database
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'message_database.db'),
  );


  runApp(MyApp());
}

