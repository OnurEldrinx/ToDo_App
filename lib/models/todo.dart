import 'package:flutter/material.dart';

class Todo {
  String title;
  String? tag;
  Color? tagColor;
  bool checked;
  bool loading;

  Todo({
    required this.title,
    this.tag,
    this.tagColor,
    this.checked = false,
    this.loading = false,
  });
}
