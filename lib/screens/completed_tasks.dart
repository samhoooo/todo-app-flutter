import 'package:flutter/material.dart';
import '../models/task.dart';

class CompletedTasks extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) toggleTask;
  const CompletedTasks(
      {super.key, required this.tasks, required this.toggleTask});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isChecked).toList();
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
                title: Text(task.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(task.description),
                onTap: () => toggleTask(task.id),
                leading: const Icon(Icons.check_circle,
                    color: Colors.green, size: 28)),
          );
        },
      ),
    );
  }
}
