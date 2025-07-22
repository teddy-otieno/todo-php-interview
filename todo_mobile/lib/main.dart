import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_mobile/add_todo.dart';
import 'package:todo_mobile/models/Todo.dart';
import 'package:todo_mobile/services/todoService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var todoService = TodoService();

  List<Todo> todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadTodos();
  }

  void loadTodos() async {
    await todoService.listTodos().match((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return e;
    }, (d) {
      todos = d;
    }).run();
  }

  void deleteTodo(int id) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Tasks'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.list(children: []),
          SliverList.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index].title),
                subtitle: Text(todos[index].description),
                trailing: IconButton(
                  icon: const Icon(Icons.import_contacts_outlined),
                  onPressed: () {
                    deleteTodo(todos[index].id);
                  },
                ),
              );
            },
            itemCount: todos.length,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const AddTodo()));
        },
        label: Text('Add Task'),
      ),
    );
  }
}
