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
      home: const HomePage(),
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
  final List<String> _pageNames = ['My Tasks', 'Completed Tasks', 'Welcome'];
  final List<Map<String, dynamic>> _tasks = [
    {
      'id': 1,
      'title': 'Task 1',
      'time': 'Fri, Apr 21 2:15 PM',
      'isChecked': false
    },
    {
      'id': 2,
      'title': 'Task 2',
      'time': 'Fri, Apr 21 2:15 PM',
      'isChecked': false
    },
    {
      'id': 3,
      'title': 'Task 3',
      'time': 'Fri, Apr 21 2:15 PM',
      'isChecked': false
    },
  ];

  void _toggleTask(int taskId) {
    setState(() {
      int index = _tasks.indexWhere((task) => task['id'] == taskId);
      _tasks[index]['isChecked'] = !_tasks[index]['isChecked'];
    });
  }

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      MyTasks(tasks: _tasks, toggleTask: _toggleTask),
      CompletedTasks(tasks: _tasks, toggleTask: _toggleTask),
      const Account(),
    ];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: Text(_pageNames[_selectedIndex],
                style: const TextStyle(
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
            backgroundColor: Colors.green[400],
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomBarItemTapped,
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
  final List<Map<String, dynamic>> tasks;
  final Function(int) toggleTask;

  const MyTasks({super.key, required this.tasks, required this.toggleTask});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    final pendingTasks =
        widget.tasks.where((task) => task['isChecked'] == false).toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: pendingTasks.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                title: Text(pendingTasks[index]['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(pendingTasks[index]['time']!),
                onTap: () {
                  widget.toggleTask(pendingTasks[index]['id']);
                },
                trailing: Icon(
                    pendingTasks[index]['isChecked']
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: Colors.green,
                    size: 28)),
          );
        },
      ),
    );
  }
}

class CompletedTasks extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final Function(int) toggleTask;
  const CompletedTasks(
      {super.key, required this.tasks, required this.toggleTask});

  @override
  Widget build(BuildContext context) {
    final completedTasks =
        tasks.where((task) => task['isChecked'] == true).toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final task = completedTasks[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                title: Text(task['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(task['time']!),
                onTap: () => toggleTask(task['id']),
                trailing: const Icon(Icons.check_circle,
                    color: Colors.green, size: 28)),
          );
        },
      ),
    );
  }
}

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('account'));
  }
}
