import 'package:flutter/material.dart';
import 'package:my_first_app/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
  final String category;
  // final void Function(int) navigate;
  const DeleteDialog({
    super.key,
    required this.category,
    // required this.navigate
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete_sweep),
      onPressed:
          () => showDialog<String>(
            context: context,
            builder:
                (BuildContext context) => AlertDialog(
                  title: Text('Are you sure deleting $category?'),
                  content: Text(
                    'you are going to delete $category and all the tasks inside it.',
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        final taskProvider = Provider.of<TaskProvider>(
                          context,
                          listen: false,
                        );
                        taskProvider.deleteCategory(category);

                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
          ),
    );
  }
}
