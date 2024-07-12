import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../widgets/todo_list.dart';
import '../widgets/add_todo_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late TabController _tabController;

  final List<List<Todo>> _todos = [
    [Todo(
      title: 'I will plan my day by using this great To-Do App developed by Onur Öztop',
      tag: "Flutter",
      tagColor: Colors.blue[100],
      checked: false,
    )],
    [],
    [],
    [],
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);

    _tabController.addListener(() {
      _currentIndex = _tabController.index;
    });
  }

  void _addTodoItem(String title, String? tag, Color? tagColor) {
    setState(() {
      _todos[_currentIndex].add(Todo(
        title: title,
        tag: tag,
        tagColor: tagColor,
        checked: false,
      ));
    });
  }

  void _showAddTodoDialog(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddTodoDialog(onAdd: _addTodoItem);
      },
    );
  }

  String getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEE, MMM dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Today'),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(color: Colors.black,Icons.calendar_today, size: 20),
                    const SizedBox(width: 5),
                    Text(getFormattedDate(), style: const TextStyle(color: Colors.black,fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          bottom: TabBar(isScrollable: true,
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Tomorrow'),
              Tab(text: 'Rest of the Week'),
              Tab(text: 'Later'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _todos.map((todoList) => TodoList(todos: todoList)).toList(),
        ),
        floatingActionButton: FloatingActionButton(elevation: 10,
          onPressed: () => _showAddTodoDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
