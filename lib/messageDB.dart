import 'dart:convert';

import 'package:messages_value/message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MessagesDataBase{
  //global field, instance of constructor
  static final MessagesDataBase instance = MessagesDataBase._init();
  static Database? _database;
  //constructor
  MessagesDataBase._init();


  //to open database
  Future<Database?> get database async{
    if (_database != null ) //if already created
      return _database;
    _database = await _initDB('messagesDB.db'); //file name to be created
    return _database!;
  }

  //to initiallize
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('DB returned or fetched');

    return await openDatabase(path, version: 1, onCreate: _createDB);

  }

  //create database tables
  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT'; //could also just write directly  AUTOINCREMENT
  print('DB created');
    await db.execute('''
    CREATE TABLE $tableMessages (
    ${MessageFields.id} $idType,
    ${MessageFields.text} TEXT NOT NULL
    )
    ''');
  }

  //CRUD
  //Create
  Future<SingleMessage> createMessage( SingleMessage message) async {
    //to get a reference of the db
    final db = await instance.database;
    // final id = await db
    // .rawInsert('INSERT INTO Messages (${MessageFields.id}, ${MessageFields.text}) VALUES ${json[MessageFields.id]}, ${json[MessageFields.text]}');
    final id = await db!.insert(tableMessages, message.toJson());
    return message.copy(id: id);
  }

  Future<SingleMessage> readMessage(int id) async{
    final db = await instance.database;
    final maps = await db!.query(
      tableMessages,
      columns: MessageFields.values,
      where: '${MessageFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty){
      return SingleMessage.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }

  }

  Future<List<SingleMessage>> readAllMessages() async{
    final db = await instance.database;
    final result = await db!.query(tableMessages);
    return result.map((json) => SingleMessage.fromJson(json)).toList();
  }
  //close DB
  // Future close() async{
  //   final db = await instance.database;
  //   db!.close();
  // }



}