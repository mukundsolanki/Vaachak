import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'widgets/bottom_model_sheet.dart';

class HomeScreen extends StatefulWidget {
  String get title => 'as';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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

  void removeText(int index) {
    setState(() {
      texts.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello User,',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: texts.isEmpty
                  ? Text(
                      'No Signs Yet',
                      style: TextStyle(
                        color: Colors.white60,
                      ),
                    )
                  : ListView.builder(
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                                          angle: _rotateController.value * 5.0 * math.pi,
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
                                  removeText(index);
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
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) =>
                MyBottomSheet(onTextCreated: addText),
          );
        },
        label: Text('ADD SIGN'),
        icon: Icon(Icons.edit),
      ),
    );
  }
}


class TextInfo {
  final String text;
  bool isLoading;

  TextInfo({required this.text, this.isLoading = false});
}