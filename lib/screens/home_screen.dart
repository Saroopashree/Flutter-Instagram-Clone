import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_data.dart';
import 'package:flutter_instagram_clone/screens/activity_screen.dart';
import 'package:flutter_instagram_clone/screens/create_post_screen.dart';
import 'package:flutter_instagram_clone/screens/feed_screen.dart';
import 'package:flutter_instagram_clone/screens/profile_screen.dart';
import 'package:flutter_instagram_clone/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(userId: Provider.of<UserData>(context).currentUserId),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInCubic);
        },
        activeColor: Colors.black,
        inactiveColor: Colors.black38,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.home,
            size: 37.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.search,
            size: 37.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.plus_circled,
            size: 37.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.heart,
            size: 37.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            CupertinoIcons.person,
            size: 37.0,
          )),
        ],
      ),
    );
  }
}
