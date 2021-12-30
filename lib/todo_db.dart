import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

Future<Database> database = connDB();

Future<Database> connDB() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(50), detail VARCHAR(500))',
      );
    },
    version: 1,
  );

  return database;
}

// insert Todo
Future<void> insertTodo(Todo todo) async {
  final db = await database;
  await db.insert(
    'todos',
    todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print('Insertしました。');
}

// Select all
Future<List<Todo>> getAllTodo() async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('todos');
  print('get');
  return List.generate(maps.length, (idx) {
    return Todo(
      id: maps[idx]['id'],
      title: maps[idx]['title'],
      detail: maps[idx]['detail'],
    );
  });
}

Future<Todo> getTodo(int? id) async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('todos',
    where: 'id = ?',
    whereArgs: [id]);

  return Todo(
    id: maps[0]['id'],
    title: maps[0]['title'],
    detail: maps[0]['detail']
  );
}

// delete Todo
Future<void> deleteTodo(int? id) async {
  final db = await database;
  await db.delete(
    'todos',
    where: 'id = ?',
    whereArgs: [id],
  );
}

class Todo {
  final int? id;
  final String title;
  final String detail;


  Todo({
    this.id,
    required this.title,
    required this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, detail: $detail}';
  }


}