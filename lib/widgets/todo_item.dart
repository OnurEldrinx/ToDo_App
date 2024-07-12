import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onAddTag;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onAddTag,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.title),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      child: ListTile(
        leading: Checkbox(
          value: todo.checked,
          onChanged: onChanged,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.checked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: todo.tag == null ?
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: onAddTag,
                child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8)
                ),
                //alignment: Alignment.center,
                child: const Row(
                  children: [
                    Icon(Icons.add,size: 16,color: Colors.teal,),
                    Text(style: TextStyle(fontSize: 16,color: Colors.teal),'Add Tag'),
                  ],
                ))
            ),
          ],
        )
            : Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: todo.tagColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(todo.tag!),
            ),
            if (todo.loading)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
          ],
        ),
      ),
    );
  }
}
