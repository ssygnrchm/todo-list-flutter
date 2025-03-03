import 'package:flutter/material.dart';
import 'package:my_first_app/data/datasources/local/task_memory_datasource.dart';
import 'package:my_first_app/data/repositories/task_repository_impl.dart';
import 'package:my_first_app/presentation/pages/login_page.dart';
import 'package:my_first_app/presentation/pages/task_list_page.dart';
import 'package:my_first_app/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => TaskRepositoryImpl(TaskMemoryDataSource())),
        ChangeNotifierProxyProvider<TaskRepositoryImpl, TaskProvider>(
          create:
              (context) => TaskProvider(
                Provider.of<TaskRepositoryImpl>(context, listen: false),
              ),
          update:
              (context, repository, previous) =>
                  previous!..setRepository(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Todo List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Poppins',
        ),
        home: const LoginPage(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  final String email;
  final String phone;

  MyHome({super.key, required this.email, required this.phone});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  TextEditingController categoryController = TextEditingController();

  List<Map<String, dynamic>> get _categoryItems {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final defaultCategories = [
      {'title': 'Daily Task', 'category': 'daily_task', 'icon': Icons.home},
      {'title': 'Homeworks', 'category': 'homeworks', 'icon': Icons.class_},
      {'title': 'Other', 'category': 'other', 'icon': Icons.settings},
    ];

    final dynamicCategories =
        provider.categories
            .where(
              (category) =>
                  !['daily_task', 'homeworks', 'other'].contains(category),
            )
            .map(
              (category) => {
                'title': category,
                'category': category,
                'icon': Icons.list,
              },
            )
            .toList();
    return [...defaultCategories, ...dynamicCategories];
  }

  void addCategory() {
    if (categoryController.text.isNotEmpty) {
      final provider = Provider.of<TaskProvider>(context, listen: false);
      provider.addCategory(categoryController.text);
      categoryController.clear();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final provider = Provider.of<TaskProvider>(context, listen: false);
    final category = _categoryItems[index]['category'];

    Future.microtask(() {
      provider.setCategory(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = _categoryItems[_selectedIndex];
    return Scaffold(
      appBar: AppBar(title: Text(category['title']), centerTitle: true),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("asset/images/abu.png"),
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
            const ListTile(title: Text("Category")),
            ListView.builder(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _categoryItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(_categoryItems[index]['icon']),
                  title: Text(_categoryItems[index]['title']),
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
      // body: Container(child: allPages.elementAt(_selectedIndex)),
      body: TaskListPage(
        title: category['title'],
        category: category['category'],
      ),
    );
  }
}
