import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './my_tasks.dart';
import './completed_tasks.dart';
import '../widgets/task_form.dart';
import '../models/task.dart';

var uuid = Uuid();

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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();

  final List<Task> _tasks = [
    Task(
      id: uuid.v4(),
      title: 'Task 1',
      description: 'This is an example task',
    ),
  ];

  void _addTask() {
    if (_titleController.text.isEmpty) return;

    setState(() {
      _tasks.add(Task(
        id: uuid.v4(),
        title: _titleController.text,
        description: _descriptionController.text,
      ));
    });

    _titleController.clear();
    _descriptionController.clear();
    Navigator.pop(context); // Close the drawer
  }

  void _editTask(String taskId) {
    if (_titleController.text.isEmpty) return;

    setState(() {
      int index = _tasks.indexWhere((task) => task.id == taskId);
      _tasks[index] = Task(
        id: taskId,
        title: _titleController.text,
        description: _descriptionController.text,
        isChecked: _tasks[index].isChecked,
      );
    });

    _titleController.clear();
    _descriptionController.clear();
    Navigator.pop(context);
  }

  void _removeTask(String taskId) {
    setState(() {
      _tasks.removeWhere((task) => task.id == taskId);
    });

    _titleController.clear();
    _descriptionController.clear();
    Navigator.pop(context);
  }

  void _toggleTask(String taskId) {
    setState(() {
      int index = _tasks.indexWhere((task) => task.id == taskId);
      _tasks[index].isChecked = !_tasks[index].isChecked;
    });
  }

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddTaskDrawer(Task? taskToEdit) {
    if (taskToEdit != null) {
      _titleController.text = taskToEdit.title;
      _descriptionController.text = taskToEdit.description;
    } else {
      _titleController.text = '';
      _descriptionController.text = '';
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TaskForm(
          taskToEdit: taskToEdit,
          titleController: _titleController,
          descriptionController: _descriptionController,
          formKey: _formGlobalKey,
          onSubmit: () {
            if (_formGlobalKey.currentState!.validate()) {
              if (taskToEdit != null) {
                _editTask(taskToEdit.id);
              } else {
                _addTask();
              }
            }
          },
          onDelete:
              taskToEdit != null ? () => _removeTask(taskToEdit.id) : null,
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      MyTasks(
        tasks: _tasks,
        toggleTask: _toggleTask,
        showAddTaskDrawer: _showAddTaskDrawer,
      ),
      CompletedTasks(tasks: _tasks, toggleTask: _toggleTask),
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
            onPressed: () => _showAddTaskDrawer(null),
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
          ],
        ));
  }
}
