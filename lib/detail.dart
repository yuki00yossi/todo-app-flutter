import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:todoapp/todo_db.dart';


class DetailPage extends StatefulWidget {
  final int? num;

  DetailPage(this.num);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _todoTitle = "";
  String _todoDetail = "";

  Future<void> _setInfo(int? id) async {
    Todo todo = await getTodo(id);
    print("setinfo");
    print(todo);
    setState(() {
      _todoTitle = todo.title;
      _todoDetail = todo.detail;
    });
  }

  @override
  void initState() {
    super.initState();
    _setInfo(widget.num);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_todoTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(_todoDetail,
              style: Theme.of(context).textTheme.bodyText1,
            ),

          ],
        ),
      ),
    );
  }
}
