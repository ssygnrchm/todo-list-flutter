import 'package:flutter/material.dart';
import 'package:my_first_app/data/list_homework.dart';
import 'package:my_first_app/views/todolist_page.dart'; // Import your new reusable widget

class HomeworkList extends StatelessWidget {
  const HomeworkList({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoListView(title: 'homeworks', listData: homeworkListData);
  }
}
