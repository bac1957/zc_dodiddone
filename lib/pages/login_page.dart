import 'package:flutter/material.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true; // Track if it's login or registration

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: isLogin
                ? [secondaryColor, primaryColor]
                : [primaryColor, secondaryColor],
            stops: const [0.1, 0.9], // Primary color takes 90% of the space
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              // Row for logo and text
              Padding(
                padding: const EdgeInsets.only(top: 40.0), // Add top padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                  children: [
                    // Image.asset for the logo
                    Image.asset(
                      'assets/log.png',
                      width: 64,
                      height: 64,
                    ),
                    const SizedBox(width: 16), // Space between logo and text
                    // Text for "Zerocoder"
                    const Text(
                      'ZEROCODER',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              // RichText for the app name
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Do-',
                      style: TextStyle(color: primaryColor),
                    ),
                    const TextSpan(
                      text: 'Did-',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Done',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Почта',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Пароль',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (!isLogin) // Show only on registration page
                const SizedBox(height: 20),
              if (!isLogin) // Show only on registration page
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Повторить пароль',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isLogin
                      ? primaryColor
                      : secondaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(isLogin ? 'Войти' : 'Зарегистрироваться'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin; // Toggle between login and registration
                  });
                },
                child: Text(
                  isLogin
                      ? 'У меня еще нет аккаунта ...'
                      : 'Уже есть аккаунт ...',
                  style: const TextStyle(
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
