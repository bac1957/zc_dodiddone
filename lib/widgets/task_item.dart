import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Импортируем пакет intl

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime deadline;
  final Function? onEdit; // Функция для редактирования
  final Function? onDelete; // Функция для удаления

  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.deadline,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Форматируем дату и время
    String formattedDeadline = DateFormat('dd.MM.yy HH:mm').format(deadline);

    // Определяем срочность задачи
    Duration timeUntilDeadline = deadline.difference(DateTime.now());
    Color gradientStart;
    if (timeUntilDeadline.inDays < 1) {
      gradientStart = const Color.fromARGB(255, 240, 124, 115); // Срочная
    } else if (timeUntilDeadline.inDays < 2) {
      gradientStart = Colors.yellow; // Средняя срочность
    } else {
      gradientStart = Colors.green; // Не срочная
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientStart, Color.fromARGB(255, 255, 255, 255)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Цвет текста черный
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onEdit as void Function()?,
                  icon: const Icon(Icons.edit, color: Color.fromARGB(255, 56, 55, 55)), // Черный цвет иконки
                ),
                IconButton(
                  onPressed: onDelete as void Function()?,
                  icon: const Icon(Icons.delete, color: Color.fromARGB(255, 56, 55, 55)), // Черный цвет иконки
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Цвет текста черный
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Дедлайн: $formattedDeadline', // Используем отформатированную дату
                  style: const TextStyle(fontSize: 14,
                  color: Colors.black, // Цвет текста черный
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}