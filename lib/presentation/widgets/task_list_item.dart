import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  final String id;
  final String title;
  final bool isDone;
  final Function(String) onToogle;
  final Function(String) onDelete;

  const TaskListItem({
    super.key,
    required this.id,
    required this.title,
    required this.isDone,
    required this.onToogle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: CheckboxListTile(
          value: isDone,
          onChanged: (_) => onToogle(id),
          activeColor: isDone ? Colors.grey : null,
          title: Text(
            title,
            textAlign: TextAlign.end,
            style:
                isDone
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
          ),
          secondary: IconButton(
            onPressed: () => onDelete(id),
            icon: Icon(
              Icons.delete,
              color: isDone ? Colors.grey : Colors.redAccent[700],
            ),
          ),
        ),
      ),
    );
  }
}
