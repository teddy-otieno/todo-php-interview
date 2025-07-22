import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('title'))),
          TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('decoration'))),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: () {}, child: Text('Create Task')),
          )
        ],
      ),
    );
  }
}
