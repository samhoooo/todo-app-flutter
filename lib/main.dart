import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MyTasks(),
    CompletedTasks(),
    Account(),
  ];

  final List<String> _pageNames = ['My Tasks', 'Completed Tasks', 'Welcome'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: Text(_pageNames[_selectedIndex],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green[400],
            centerTitle: false,
          ),
        ),
        body: _screens[_selectedIndex],
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green[400],
            shape: CircleBorder()),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted), label: 'My Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer), label: 'Completed Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ));
  }
}

class MyTasks extends StatefulWidget {
  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  final List<Map<String, dynamic>> tasks = [
    {'title': 'Task 1', 'time': 'Fri, Apr 21 2:15 PM', 'isChecked': false},
    {'title': 'Task 2', 'time': 'Fri, Apr 21 2:15 PM', 'isChecked': false},
    {'title': 'Task 3', 'time': 'Fri, Apr 21 2:15 PM', 'isChecked': false},
  ];

  void _toggleTask(int index) {
    setState(() {
      tasks[index]['isChecked'] = !tasks[index]['isChecked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(tasks[index]['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(tasks[index]['time']!),
                trailing: GestureDetector(
                    onTap: () {
                      _toggleTask(index);
                    },
                    child: Icon(
                        tasks[index]['isChecked']
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: Colors.green,
                        size: 28))),
          );
        },
      ),
    );
  }
}

class CompletedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('completed tasks'));
  }
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('account'));
  }
}
