import 'package:flutter/material.dart';

import 'package:todoapp/todo_db.dart';


class AddForm extends StatelessWidget {

  String taskName = '';
  String taskDetail = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: GlobalKey<FormState>(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Task Name",
                  hintText: 'Enter your task name',
                ),
                onChanged: (text) {
                  taskName = text;
                },
                autofocus: true,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: null,
                minLines:5,
                decoration: const InputDecoration(
                  labelText: "Task Detail",
                  hintText: 'Enter your task name',
                  alignLabelWithHint: true,
                ),
                onChanged: (text) {
                  taskDetail = text;
                },
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              // submit button
              ElevatedButton(
                onPressed: () async {
                  // insert task then back to home page
                  Todo todo = Todo(
                    title: taskName,
                    detail: taskDetail
                  );
                  print(todo);
                  await insertTodo(todo);
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),

            ],
          ),
        ),
      ),




    );
  }
}