import 'package:flutter/material.dart';
import '../pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEmailVerified = false; // Replace with actual user data

  @override
  Widget build(BuildContext context) {
    return Padding (
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            const CircleAvatar(
              radius: 80,
            //   backgroundImage: NetworkImage(
            //       'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200&d=mp&r=g'), // Replace with actual user avatar
            // ),
            backgroundImage: const AssetImage(
                'assets/vasilisa.png'), 
            ),
            const SizedBox(height: 20),
            // Email
            const Text(
              'example@email.com', // Replace with actual user email
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Email verification button
            if (!_isEmailVerified)
              ElevatedButton(
                onPressed: () {
                // Обработка отправки запроса подтверждения почты
                // Например, можно показать диалог с сообщением о том, что письмо отправлено
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Подтверждение почты'),
                    content: const Text(
                        'Письмо с подтверждением отправлено на ваш адрес.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
                child: const Text('Подтвердить почту'),
              ),
            const SizedBox(height: 20),
            // Logout button
            ElevatedButton(
            onPressed: () {
              // Обработка выхода из профиля
              // Например, можно перейти на страницу входа
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
            // style: ElevatedButton.styleFrom(
            //   backgroundColor: Color.fromARGB(255, 137, 11, 2), // Красный цвет для кнопки выхода
            //   foregroundColor: Color.fromARGB(255, 255, 255, 255), // Белый цвет для текста кнопки выхода
            // ),
            child: const Text('Выйти'),
          ),
          ],
        ),
      );
  }
}
