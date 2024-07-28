import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Sample task data (replace with actual data from your backend)
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Купить продукты',
      'description': 'Молоко, яйца, хлеб',
      'completed': false,
    },
    {
      'title': 'Записаться на прием к врачу',
      'description': 'Терапевт, 10:00',
      'completed': true,
    },
    {
      'title': 'Позвонить маме',
      'description': 'Спросить как дела',
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task['title']),
            subtitle: Text(task['description']),
            trailing: Checkbox(
              value: task['completed'],
              onChanged: (value) {
                setState(() {
                  task['completed'] = value!;
                });
              },
            ),
          );
        },
    );
  }
}
