import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'widgets/call.dart';

class ConnectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/call.json',
              width: 400,
            ),
            // Start Call Button
            ElevatedButton.icon(
              onPressed: () {
                // Call ID is used to establish connection between two diifferent users
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CallPage(),),);
              },
              icon: Icon(Icons.video_call),
              label: Text('Start Call'),
            ),
          ],
        ),
      ),
    );
  }
}