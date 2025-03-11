import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String category;
  const DeleteDialog({super.key, required this.category});

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
                      onPressed: () {},
                      child: const Text('OK'),
                    ),
                  ],
                ),
          ),
    );
  }
}
