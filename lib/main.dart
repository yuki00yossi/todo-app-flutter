import 'package:flutter/material.dart';
import 'package:todoapp/detail.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  void _viewDetailPage(int num) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(num.toString())),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          for (var i = 0; i < 50; i++) ...{
            ListTile(
              leading: Icon(Icons.task_alt),
              title: Text('Task${i}'),
              onTap: () {
                  _viewDetailPage(i);
              },
            ),
          }
        ],
      ),
    );
  }
}
