import 'package:flutter/material.dart';
import 'package:my_first_app/data/list_daily.dart';
import 'package:my_first_app/views/todolist_page.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoListView(title: 'daily_task', listData: dailyListData);
  }
}
