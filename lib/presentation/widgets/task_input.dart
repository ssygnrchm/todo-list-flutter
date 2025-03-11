import 'package:flutter/material.dart';

class TaskInput extends StatefulWidget {
  final Function(String) onAddTask;

  const TaskInput({super.key, required this.onAddTask});

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController _controller = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;

  void _addTask() {
    // FocusScope.of(context).unfocus();
    if (_controller.text.isNotEmpty) {
      widget.onAddTask(_controller.text);
      _controller.clear();
      _isFocus = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: false,
            canRequestFocus: _isFocus,
            controller: _controller,
            onTapAlwaysCalled: true,
            onTap: () {
              print('textfield tapped');
              print(_isFocus);
              setState(() {
                _isFocus =
                    true; //must be tapped twice, maybe try using povider instead of setState???
              });
            },
            onTapOutside: (event) {
              _isFocus = false;
            },
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
          iconSize: 36,
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
