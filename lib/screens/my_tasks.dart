import 'package:flutter/material.dart';
import '../models/task.dart';

class MyTasks extends StatefulWidget {
  final List<Task> tasks;
  final Function(String) toggleTask;
  final Function(Task?) showAddTaskDrawer;

  const MyTasks({
    super.key,
    required this.tasks,
    required this.toggleTask,
    required this.showAddTaskDrawer,
  });

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  // Add this map to track visual states
  final Map<String, bool> _visualStates = {};

  @override
  Widget build(BuildContext context) {
    final pendingTasks = widget.tasks.where((task) => !task.isChecked).toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: pendingTasks.length,
        itemBuilder: (context, index) {
          final task = pendingTasks[index];
          _visualStates[task.id] ??= false;

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
                title: Text(task.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(task.description),
                onTap: () => widget.showAddTaskDrawer(task),
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      _visualStates[task.id] = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      widget.toggleTask(task.id);
                    });
                  },
                  child: Icon(
                      _visualStates[task.id] == true
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: Colors.green,
                      size: 28),
                )),
          );
        },
      ),
    );
  }
}
