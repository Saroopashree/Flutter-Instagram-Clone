import 'package:flutter/cupertino.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Search Screen",
        style: TextStyle(fontSize: 35.0),
      ),
    );
  }
}
