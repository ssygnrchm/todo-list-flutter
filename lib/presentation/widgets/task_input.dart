import 'package:flutter/material.dart';

class TaskInput extends StatefulWidget {
  final Function(String) onAddTask;

  const TaskInput({super.key, required this.onAddTask});

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      widget.onAddTask(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onEditingComplete: _addTask,
            decoration: InputDecoration(
              hintText: 'Enter a task',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        IconButton.filled(
          onPressed: _addTask,
          icon: const Icon(Icons.add),
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }
}
