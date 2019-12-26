import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';
import 'package:flutter_instagram_clone/services/database_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _username;
  String _website;
  String _bio;
  String _profileImageURL;

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      User newUser = User(
        id: widget.user.id,
        name: _name,
        username: _username,
        bio: _bio,
        profileImageURL: _profileImageURL,
        website: _website,
      );

      DatabaseService.updateUser(newUser);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Profile"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.blue,
                size: 30.0,
              ),
              onPressed: _submit,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: NetworkImage(
                        "https://previews.123rf.com/images/anastasiatukaeva/anastasiatukaeva1702/anastasiatukaeva170200139/71898602-portrait-cartoon-of-a-bearded-man-in-a-barbershop-the-head-is-brutal-man-vector-illustration-isolate.jpg"),
                  ),
                  FlatButton(
                    child: Text(
                      "Change Profile Photo",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15.5,
                        fontFamily: "Verdana",
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: TextFormField(
                      initialValue: widget.user.name,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: 17.0),
                      ),
                      validator: (input) =>
                          input.trim().length < 1 ? "Enter a valid name" : null,
                      onSaved: (input) => _name = input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: TextFormField(
                      initialValue: widget.user.username,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(fontSize: 17.0),
                      ),
                      validator: (input) => input.trim().length < 1
                          ? "Enter a valid username"
                          : null,
                      onSaved: (input) => _username = input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: TextFormField(
                      initialValue: widget.user.website,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: "Website",
                        labelStyle: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: TextFormField(
                      initialValue: widget.user.bio,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: "Bio",
                        labelStyle: TextStyle(fontSize: 17.0),
                      ),
                      validator: (input) => input.trim().length > 140
                          ? "Please enter a bio less than 140 characters"
                          : null,
                      onSaved: (input) => _bio = input,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
