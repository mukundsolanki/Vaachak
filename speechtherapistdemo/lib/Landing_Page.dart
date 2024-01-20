import 'package:speechtherapistdemo/video_call.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/vc.jpg',
              width: 400,
            ),
            // Start Call Button
            ElevatedButton.icon(
              onPressed: () {
                // Call ID is used to establish connection between two different users
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CallPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.video_call,
                color: Colors.black,
              ),
              label: Text(
                'Start Call',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 207, 61, 51)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(150, 48),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Connect to the call\n ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
           /* Text(
              '<username>',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}