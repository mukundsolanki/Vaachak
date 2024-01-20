import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaachakapp/pages/states/app_provider.dart';
import 'dart:math' as math;
import 'widgets/bottom_model_sheet.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  String get title => 'as';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<TextInfo> texts = [];
  late AnimationController _rotateController;

  void addText(String newText) {
    setState(() {
      texts.add(TextInfo(text: newText, isLoading: true));
    });

    // Simulate loading for 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        // Update the loading state to false after 5 seconds
        texts.last.isLoading = false;
      });

      _rotateController.stop();
    });
  }

 

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _rotateController.repeat();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }
  Future<void> _sendHttpRequest(String enteredText) async {
    final ipAddressProvider = Provider.of<IPAddressProvider>(context, listen: false);
    final ipAddress = ipAddressProvider.ipAddress;

    final port = 5050;
    final url = Uri.parse('http://$ipAddress:$port/delete-sign');

    try {
      final response = await http.post(url, body: {'text': enteredText});

      if (response.statusCode == 200) {
        print('Text sent successfully!');
      } else {
        print('Failed to send text. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello User,',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            child: Center(
              child: texts.isEmpty
                  ? Text(
                      'No Signs Yet',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    )
                  : ListView.builder(
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 70,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  texts[index].text,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              texts[index].isLoading
                                  ? AnimatedBuilder(
                                      animation: _rotateController,
                                      builder: (context, child) {
                                        return Transform.rotate(
                                          angle: _rotateController.value *
                                              5.0 *
                                              math.pi,
                                          child: Icon(
                                            Icons.sync_rounded,
                                            color: Colors.blue,
                                          ),
                                        );
                                      },
                                    )
                                  : Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                              SizedBox(width: 8.0),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                 String textToRemove = texts[index].text;
                              _sendHttpRequest(textToRemove); // Send HTTP request with the text

                              setState(() {
                                texts.removeAt(index);
                              });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: Colors.blueGrey.shade300,
        backgroundColor: Color.fromARGB(255, 207, 61, 51),
        onPressed: () {
          showModalBottomSheet(
             backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) =>
                MyBottomSheet(onTextCreated: addText),
          );
        },
        label: Text(
          'ADD SIGN',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        icon: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TextInfo {
  final String text;
  bool isLoading;

  TextInfo({required this.text, this.isLoading = false});
}