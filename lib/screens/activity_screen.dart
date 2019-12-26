import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Activity Screen",
        style: TextStyle(fontSize: 35.0),
      ),
    );
  }
}
