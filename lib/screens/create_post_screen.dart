import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Create Post Screen",
        style: TextStyle(fontSize: 35.0),
      ),
    );
  }
}
