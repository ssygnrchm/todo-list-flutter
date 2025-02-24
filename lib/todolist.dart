import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  int _selectedIndex = 0;
  List<String> tasks = []; // List to store tasks
  List<String> completedTasks = []; // List to store completed Tasks
  List<Map<String, dynamic>> categoryItems = [
    {'title': 'Daily Task', 'icon': Icons.home},
    {'title': 'Homeworks', 'icon': Icons.class_},
    {'title': 'Settings', 'icon': Icons.settings},
  ];

  String _selectedPage = "";

  TextEditingController taskController =
      TextEditingController(); // Get user input

  TextEditingController categoryController = TextEditingController();

  // Add Task Function
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text); // add task to list
        taskController.clear(); // clear input field
      });
    }
  }

  // Remove Task Function
  void removeTask(int index, List list) {
    setState(() {
      list.removeAt(index); // remove task from the list based on index
    });
  }

  // Move task to Done
  void moveTask(int index, List list) {
    if (list == completedTasks) {
      setState(() {
        tasks.add(completedTasks[index]);
        removeTask(index, completedTasks);
      });
    } else if (list == tasks) {
      setState(() {
        completedTasks.add(tasks[index]);
        removeTask(index, tasks);
      });
    }
  }

  // On tapped listview in drawer
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = categoryItems[_selectedIndex]['title'];
    });
  }

  // Add category in drawer
  void addCategory() {
    if (categoryController.text.isNotEmpty) {
      setState(() {
        categoryItems.add({
          'title': categoryController.text,
          'icon': Icons.bookmark,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Todo List 📋'), centerTitle: true),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("asset/abu.png"),
                    radius: 48,
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Classy Cat",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "classycat@gmail.com",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(title: Text("Category")),
            ListView.builder(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(categoryItems[index]['icon']),
                  title: Text(categoryItems[index]['title']),
                  selected: _selectedIndex == index,
                  onTap: () {
                    _onItemTapped(index);

                    Navigator.pop(context);
                  },
                );
              },
            ),
            Divider(thickness: 1),
            ListTile(title: Text("Add category")),
            ListTile(
              leading: IconButton(
                onPressed: addCategory,
                icon: Icon(Icons.add),
              ),
              title: TextField(
                controller: categoryController,
                decoration: InputDecoration(hintText: "add new list category"),
              ),
            ),
            Divider(thickness: 1),
            ListTile(title: Text(_selectedPage)),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              return Card(
                                // margin: const EdgeInsets.only(bottom: 8),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: CheckboxListTile(
                                    value: false,
                                    onChanged: (bool? value) {
                                      moveTask(index, tasks);
                                    },
                                    title: Text(
                                      tasks[index],
                                      textAlign: TextAlign.end,
                                    ),
                                    secondary: IconButton(
                                      onPressed: () => removeTask(index, tasks),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent[700],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (completedTasks.isNotEmpty) ...[
                    sectionTitle('Done'),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: completedTasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // margin: const EdgeInsets.only(bottom: 8),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: CheckboxListTile(
                              value: true,
                              onChanged: (bool? value) {
                                moveTask(index, completedTasks);
                              },
                              activeColor: Colors.grey,
                              title: Text(
                                completedTasks[index],
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              secondary: IconButton(
                                onPressed:
                                    () => removeTask(index, completedTasks),
                                icon: Icon(Icons.delete, color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
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

//  // DropdownMenuEntry labels and values for the second dropdown menu.
// enum IconLabel {
//   smile('Smile', Icons.sentiment_satisfied_outlined),
//   cloud('Cloud', Icons.cloud_outlined),
//   brush('Brush', Icons.brush_outlined),
//   heart('Heart', Icons.favorite);

//   const IconLabel(this.label, this.icon);
//   final String label;
//   final IconData icon;

//   static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
//     values.map<IconEntry>(
//       (IconLabel icon) => IconEntry(value: icon, label: icon.label, leadingIcon: Icon(icon.icon)),
//     ),
//   );
// }
