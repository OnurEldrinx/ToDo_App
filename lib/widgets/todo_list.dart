import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'todo_item.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final TextEditingController _tagTextController = TextEditingController();

  void _deleteTodoItem(int index) {
    setState(() {
      widget.todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        return TodoItem(
          todo: widget.todos[index],
          onChanged: (bool? checked) {
            setState(() {
              widget.todos[index].checked = checked ?? false;
            });
          },
          onAddTag: () {
            showModalBottomSheet(
              elevation: 5,
              showDragHandle: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(controller: _tagTextController, decoration: const InputDecoration(labelText: "Tag")),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.todos[index].tag = _tagTextController.text;
                            widget.todos[index].tagColor = Colors.orange[100];
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                );
              },
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
            );
          },
          onDelete: () => _deleteTodoItem(index),
        );
      },
    );
  }
}
