import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/connect_screen.dart';
import 'pages/learn_screen.dart';
import 'pages/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'VAACHAK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final screens = [
    HomeScreen(),
    ConnectScreen(),
    LearnScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          indicatorColor: Colors.grey.shade900,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) =>
                {setState(() => this.index = index)},
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                label: 'Home',
                selectedIcon: Icon(
                  Icons.home_filled,
                  color: Color.fromARGB(255, 207, 61, 51),
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.connect_without_contact_outlined,
                  color: Colors.white,
                ),
                label: 'Connect',
                selectedIcon: Icon(
                  Icons.connect_without_contact,
                  color: Color.fromARGB(255, 207, 61, 51),
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.language_outlined,
                  color: Colors.white,
                ),
                label: 'Languages',
                selectedIcon: Icon(
                  Icons.language,
                  color: Color.fromARGB(255, 207, 61, 51),
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                ),
                label: 'Settings',
                selectedIcon: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 207, 61, 51),
                ),
              ),
            ]),
      ),
    );
  }
}