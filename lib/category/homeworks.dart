import 'package:flutter/material.dart';
import 'package:my_first_app/data/list_homework.dart';
import 'package:my_first_app/model/list_model.dart';

class HomeworkList extends StatefulWidget {
  const HomeworkList({super.key});

  @override
  State<HomeworkList> createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {
  TextEditingController taskController =
      TextEditingController(); // Get user input

  // Add Task Function
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        homeworkListData.add(
          ListModel(listTitle: taskController.text, listStatus: "todo"),
        ); // add task to list
        taskController.clear(); // clear input field
      });
    }
  }

  // Remove Task Function
  void removeTask(int index) {
    setState(() {
      homeworkListData.removeAt(
        index,
      ); // remove task from the list based on index
    });
  }

  // Move task to Done
  void moveTask(int index) {
    setState(() {
      if (homeworkListData[index].listStatus == "done") {
        homeworkListData[index].listStatus = "todo";
      } else {
        homeworkListData[index].listStatus = "done";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        onEditingComplete:
                            addTask, // adding task to list after hit enter
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
                      onPressed: addTask,
                      icon: Icon(Icons.add),
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 210, 198, 240),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 300),
                    child: Column(
                      children: [
                        sectionTitle('Todo'),
                        ListView.builder(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeworkListData.length,
                          itemBuilder: (context, index) {
                            if (homeworkListData[index].listStatus == "todo") {
                              return Card(
                                // margin: const EdgeInsets.only(bottom: 8),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: CheckboxListTile(
                                    value: false,
                                    onChanged: (bool? value) {
                                      moveTask(index);
                                    },
                                    title: Text(
                                      homeworkListData[index].listTitle,
                                      textAlign: TextAlign.end,
                                    ),
                                    secondary: IconButton(
                                      onPressed: () => removeTask(index),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent[700],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // if (homeworkListData.contains(ListModel(listTitle: "", listStatus: "todo")))
                sectionTitle('Done'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeworkListData.length,
                  itemBuilder: (context, index) {
                    if (homeworkListData[index].listStatus == "done") {
                      return Card(
                        // margin: const EdgeInsets.only(bottom: 8),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: CheckboxListTile(
                            value: true,
                            onChanged: (bool? value) {
                              moveTask(index);
                            },
                            activeColor: Colors.grey,
                            title: Text(
                              homeworkListData[index].listTitle,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            secondary: IconButton(
                              onPressed: () => removeTask(index),
                              icon: Icon(Icons.delete, color: Colors.grey),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding sectionTitle(String text) => Padding(
    padding: EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}
