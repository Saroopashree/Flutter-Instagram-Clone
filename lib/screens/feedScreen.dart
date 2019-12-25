import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/services/auth_service.dart';

class FeedScreen extends StatefulWidget {
  static final String id = "feed_screen";

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 40.0,
              child: Text(
                "Feed Screen",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            FlatButton(
              child: Text("Log out"),
              onPressed: () => AuthService.logout(context),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
