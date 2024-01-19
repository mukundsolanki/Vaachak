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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.purple.shade100,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) =>
                {setState(() => this.index = index)},
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                selectedIcon: Icon(Icons.home_filled),
              ),
              NavigationDestination(
                icon: Icon(Icons.connect_without_contact_outlined),
                label: 'Connect',
              ),
              NavigationDestination(
                icon: Icon(Icons.language_outlined),
                label: 'Languages',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
                selectedIcon: Icon(Icons.settings),
              ),
            ]),
      ),
    );
  }
}