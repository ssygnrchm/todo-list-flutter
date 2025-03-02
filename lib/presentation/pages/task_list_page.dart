import 'package:flutter/material.dart';
import 'package:my_first_app/presentation/providers/task_provider.dart';
import 'package:my_first_app/presentation/widgets/task_input.dart';
import 'package:my_first_app/presentation/widgets/task_list_item.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatefulWidget {
  final String title;
  final String category;

  const TaskListPage({super.key, required this.title, required this.category});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(
        context,
        listen: false,
      ).setCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TaskInput(onAddTask: (title) => provider.addTask(title)),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromARGB(255, 210, 198, 240),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height / 3,
                        ),
                        child: Column(
                          children: [
                            _sectionTitle('Todo'),
                            ListView.builder(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.todoTasks.length,
                              itemBuilder: (context, index) {
                                final task = provider.todoTasks[index];
                                return TaskListItem(
                                  id: task.id,
                                  title: task.title,
                                  isDone: false,
                                  onToogle: provider.toogleTaskStatus,
                                  onDelete: provider.deleteTask,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    _sectionTitle('Done'),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.doneTasks.length,
                      itemBuilder: (context, index) {
                        final task = provider.doneTasks[index];
                        return TaskListItem(
                          id: task.id,
                          title: task.title,
                          isDone: true,
                          onToogle: provider.toogleTaskStatus,
                          onDelete: provider.deleteTask,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}
