import 'package:flutter/material.dart';
import 'package:todo_mobile/services/todoService.dart';

import '../models/Todo.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void submitNewTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Title cannot be empty')));
      return;
    }

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Description cannot be empty')),
      );
      return;
    }

    var todoService = TodoService();

    todoService
        .addTodo(
          NewTodo(
            title: _titleController.text,
            description: _descriptionController.text,
          ),
        )
        .match(
          (onLeft) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(onLeft.message))),
          (onRight) async {
            var controller = ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Task created')));

            await controller.closed;

            if (mounted) Navigator.of(context).pop();
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('title'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('decoration'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: submitNewTask,
                child: Text('Create Task'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
