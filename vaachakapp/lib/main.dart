import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_screen.dart';
import 'pages/connect_screen.dart';
import 'pages/learn_screen.dart';
import 'pages/settings_screen.dart';
import 'package:http/http.dart' as http;
import 'pages/login_screen.dart';
import 'pages/states/app_provider.dart';
import 'pages/states/app_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => IPAddressProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
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

  Future<void> startTraining() async {
    final ipAddressProvider = Provider.of<IPAddressProvider>(context, listen: false);
    final ipAddress = ipAddressProvider.ipAddress;

    final port = 5050;
    final url = Uri.parse('http://$ipAddress:$port/start-training');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        print('Training started successfully!');
      } else {
        print('Failed to start training. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error, if any
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              startTraining(); // Call the startTraining function when sync icon is pressed
            },
            icon: Icon(
              Icons.cloud_upload_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          indicatorColor: Colors.grey[400],
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
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
                  color: Colors.black,
                ),
                label: 'Home',
                selectedIcon: Icon(
                  Icons.home_filled,
                  color: Colors.black,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.connect_without_contact_outlined,
                  color: Colors.black,
                ),
                label: 'Connect',
                selectedIcon: Icon(
                  Icons.connect_without_contact,
                  color: Colors.black,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.language_outlined,
                  color: Colors.black,
                ),
                label: 'Learnings',
                selectedIcon: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
                label: 'Settings',
                selectedIcon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
            ]),
      ),
    );
  }
}