import 'package:flutter/material.dart';
import 'widgets/bottom_model_sheet.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen Content'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => MyBottomSheet(),
          );
        },
        label: Text('ADD SIGN'),
        icon: Icon(Icons.edit),
      ),
    );
  }
}