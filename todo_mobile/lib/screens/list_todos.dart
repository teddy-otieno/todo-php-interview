import 'package:flutter/material.dart';
import 'package:relative_time/relative_time.dart';
import 'package:todo_mobile/models/Todo.dart';
import 'package:todo_mobile/screens/add_todo.dart';
import 'package:todo_mobile/services/todoService.dart';

enum TodoFilter { All, Pending, Done }

class ListTodos extends StatefulWidget {
  const ListTodos({super.key});

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  var todoService = TodoService();

  List<Todo> todos = [];
  List<Todo> filteredTodos = [];
  TodoFilter filter = TodoFilter.All;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadTodos();
  }

  List<Todo> filterTodos(List<Todo> todos) {
    return todos.where((todo) {
      switch (filter) {
        case TodoFilter.All:
          return true;
        case TodoFilter.Pending:
          return todo.isComplete == 0;
        case TodoFilter.Done:
          return todo.isComplete == 1;
      }
    }).toList();
  }

  Future<void> loadTodos() async {
    await todoService
        .listTodos()
        .match(
          (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.message)));
            return e;
          },
          (data) {
            setState(() {
              todos = data;
              filteredTodos = filterTodos(data);
            });
          },
        )
        .run();
  }

  //NOTE: (teddy) Since tasks are only marked as completed, we'll just update the isComplete column in the db;
  void deleteTodo(int id) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Tasks'),
      ),
      body: RefreshIndicator(
        onRefresh: loadTodos,
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: TodoFilter.values.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          label: Text(e.name),
                          selected: e == filter,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                filter = e;
                                filteredTodos = filterTodos(todos);
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                var todo = filteredTodos[index];

                return ListTile(
                  isThreeLine: true,
                  title: Text(
                    todo.title,
                    style: todo.isComplete == 1
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  subtitle: Text(
                    '${todo.description}\n${RelativeTime.locale(const Locale("en")).format(todo.created_at)}',
                    style: todo.isComplete == 1
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  trailing: todo.isComplete == 1
                      ? IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () {
                            deleteTodo(todo.id);
                          },
                        )
                      : null,
                );
              },
              itemCount: filteredTodos.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AddTodo(),
            ),
          );
        },
        label: Text('Add Task'),
      ),
    );
  }
}
