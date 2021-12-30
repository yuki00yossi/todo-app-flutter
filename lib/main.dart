import 'package:flutter/material.dart';
import 'package:todoapp/add_form.dart';
import 'package:todoapp/detail.dart';
import 'package:todoapp/todo_db.dart';
import 'package:todoapp/add_form.dart';
import 'dart:async';

List<Todo> todoLists = [];

void main() async {
  todoLists = await getAllTodo();
  print(todoLists);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TODO APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _setTodoInfo() async {
    todoLists = await getAllTodo();
  }

  void _deleteTodo(int? id) async {
    await deleteTodo(id);
    _getAllTodo();
  }

  void _getAllTodo() {
    print('getAllTodo');
    setState (
        () {
          _setTodoInfo();
        }
    );
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: ListView.builder(
        itemCount: todoLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.task_alt),
            title: Text('${todoLists[index].title}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(todoLists[index].id)),
              ).then( (value) {
                _getAllTodo();
              });
            },
            trailing: InkWell(
              onTap: () {
                _deleteTodo(todoLists[index].id);
              },
              child: Container(
                padding: const EdgeInsets.all(9.0),
                child: const Icon(Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddForm()),
          ).then(
              (value) {
                _getAllTodo();
              }
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
