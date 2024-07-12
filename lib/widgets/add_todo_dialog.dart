import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(String, String?, Color?) onAdd;

  const AddTodoDialog({super.key, required this.onAdd});

  @override
  AddTodoDialogState createState() => AddTodoDialogState();
}

class AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  String? _tag;
  Color? _tagColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Type your to-do here...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a to-do';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
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
                              TextField(controller: _tagController, decoration: const InputDecoration(labelText: "Tag")),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _tag = _tagController.text;
                                    _tagColor = Colors.orange[100];
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
                  icon: const Icon(Icons.tag),
                  label: const Text('Add Tag'),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Implement date addition (placeholder)
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Add date'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
                ),
                  onPressed: () {
                    if (_titleController.text.isNotEmpty) {
                      widget.onAdd(_titleController.text, _tag, _tagColor);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Create To-do'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
