import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart' as stt2;
import '../screens/all_tasks.dart';
import '../screens/profile.dart'; // Import the profile page
import 'package:intl/intl.dart'; // Импортируем пакет intl
import 'package:speech_to_text/speech_to_text.dart' as stt; // Импортируем пакет speech_to_text

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Define the widgets for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    TaskPage(),
    Text('Сегодня'),
    ProfilePage(), // Use ProfilePage for the profile tab
    Text('Выполнено'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Инициализируем SpeechToText
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _recognizedText = '';

  // Функция для открытия диалогового окна
  void _showAddTaskDialog() {
    // Инициализируем переменную для хранения выбранной даты и времени
    DateTime? selectedDateTime;

    showDialog(
      context: context,
      builder: (context) {
        // Используйте TextEditingController для управления текстовыми полями
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();

        return Dialog(
          // Устанавливаем ширину диалогового окна
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: 400, // Ширина диалогового окна
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Название',
                    filled: true, // Заполняем поле
                    fillColor: Colors.white, // Белый фон
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none, // Убираем границу
                    ),
                    // Устанавливаем русский язык для ввода
                    hintText: 'Введите название задачи',
                    hintStyle: const TextStyle(color: Colors.black), // Черный цвет подсказки
                  ),
                  // Устанавливаем русский язык для ввода
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black), // Черный цвет текста
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Описание',
                    filled: true, // Заполняем поле
                    fillColor: Colors.white, // Белый фон
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none, // Убираем границу
                    ),
                    // Устанавливаем русский язык для ввода
                    hintText: 'Введите описание задачи',
                    hintStyle: const TextStyle(color: Colors.black), // Черный цвет подсказки
                  ),
                  // Устанавливаем русский язык для ввода
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(color: Colors.black), // Черный цвет текста
                ),
                // Кнопка для выбора даты и времени
                Padding(
                  padding: const EdgeInsets.only(top: 16.0), // Отступ для кнопки
                  child: ElevatedButton(
                    onPressed: () {
                      // Вызываем showDatePicker для выбора даты
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      ).then((pickedDate) {
                        if (pickedDate == null) return;

                        // Вызываем showTimePicker для выбора времени
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((pickedTime) {
                          if (pickedTime == null) return;

                          // Сохраняем выбранную дату и время
                          selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      });
                    },
                    child: const Text('Выбрать дедлайн'),
                  ),
                ),
                // Отображаем выбранную дату и время
                if (selectedDateTime != null)
                  Text(
                    'Выбранный дедлайн: ${DateFormat('dd.MM.yy HH:mm').format(selectedDateTime!)}',
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Функция для запуска/остановки распознавания речи
  void _toggleListening() async {
    if (!_isListening) {
      // Запускаем распознавание речи
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _speechToText.listen(onResult: _onSpeechResult);
        });
      } else {
        print('Распознавание речи недоступно');
      }
    } else {
      // Останавливаем распознавание речи
      setState(() {
        _isListening = false;
      });
      _speechToText.stop();
    }
  }

  // Функция для обработки результатов распознавания речи
  void _onSpeechResult(stt2.SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
