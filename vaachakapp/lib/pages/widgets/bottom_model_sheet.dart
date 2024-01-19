import 'package:flutter/material.dart';

class MyBottomSheet extends StatefulWidget {
  final Function(String) onTextCreated;

  MyBottomSheet({required this.onTextCreated});

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Enter your text',
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              String enteredText = textEditingController.text;
              widget.onTextCreated(enteredText); // Callback to pass text to HomeScreen
              textEditingController.clear(); // Clear the text field
              Navigator.pop(context);
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}