import 'package:flutter/material.dart';
import 'package:my_first_app/service/category_service.dart';
import 'package:my_first_app/views/category/daily_task.dart';
import 'package:my_first_app/views/category/homeworks.dart';
import 'package:my_first_app/views/category/other.dart';
import 'package:my_first_app/views/todolist_page.dart';

class MyHome extends StatefulWidget {
  MyHome({super.key, required this.email, required this.phone});
  final String email;
  final String phone;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> categoryItems = [
    {'title': 'Daily Task', 'icon': Icons.home},
    {'title': 'Homeworks', 'icon': Icons.class_},
    {'title': 'Other', 'icon': Icons.settings},
  ];

  List<Widget> dynamicPages = [];

  List<Widget> get allPages => [
    Todolist(),
    HomeworkList(),
    Other(),
    ...dynamicPages,
  ];

  TextEditingController categoryController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Add category in drawer
  void addCategory() {
    if (categoryController.text.isNotEmpty) {
      final newCategoryTitle = categoryController.text;

      final newListData = CategoryService.getOrCreateListData(newCategoryTitle);

      setState(() {
        // final newListData = <ListModel>[];

        final newPage = TodoListView(
          title: newCategoryTitle,
          listData: newListData,
        );

        dynamicPages.add(newPage);

        categoryItems.add({
          'title': categoryController.text,
          'icon': Icons.bookmark,
        });

        _selectedIndex = allPages.length - 1;

        categoryController.clear(); // clear input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryItems[_selectedIndex]['title']),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("asset/abu.png"),
                    radius: 48,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Classy Cat",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.email, style: const TextStyle(fontSize: 14)),
                      Text(widget.phone, style: const TextStyle(fontSize: 14)),
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
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Daily Tasks'),
      //     BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Homeworks'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.attribution),
      //       label: 'Other',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
      body: Container(child: allPages.elementAt(_selectedIndex)),
    );
  }
}
