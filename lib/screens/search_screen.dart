import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';
import 'package:flutter_instagram_clone/screens/profile_screen.dart';
import 'package:flutter_instagram_clone/services/database_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textController = TextEditingController();
  Future<QuerySnapshot> _users;

  Widget _buildUserTiles(User user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: user.profileImageURL.isEmpty
            ? AssetImage("assets/images/user_default_image.png")
            : CachedNetworkImageProvider(user.profileImageURL),
      ),
      title: Text(user.username),
      subtitle: Text(user.name),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ProfileScreen(userId: user.id))),
    );
  }

  void _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _textController.clear());
    setState(() {
      _users = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _textController,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: "Search",
              border: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.red[700],
                ),
                onPressed: () {
                  _clearSearch();
                },
              ),
              filled: true),
          cursorColor: Colors.grey,
          onSubmitted: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _users = DatabaseService.searchUsers(input);
              });
            }
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _users == null
            ? Container()
            : FutureBuilder(
                future: _users,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    var size = MediaQuery.of(context).size;
                    return SizedBox(
                      height: size.height * 0.15,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data.documents.length == 0) {
                    return SizedBox(
                      child: Center(
                        child: Text(
                          "No users found",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = User.fromDoc(snapshot.data.documents[index]);
                      return _buildUserTiles(user);
                    },
                  );
                },
              ),
      ),
    );
  }
}
