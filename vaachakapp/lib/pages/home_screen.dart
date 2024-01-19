import 'package:flutter/material.dart';
import 'widgets/bottom_model_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> texts = [];

  void addText(String newText) {
    setState(() {
      texts.add(newText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: texts.isEmpty
            ? Text('No Texts Yet')
            : ListView.builder(
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    color: Colors.grey[200],
                    child: Text(texts[index]),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) => MyBottomSheet(onTextCreated: addText),
          );
        },
        label: Text('ADD SIGN'),
        icon: Icon(Icons.edit),
      ),
    );
  }
}