import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';
import 'package:flutter_instagram_clone/services/database_service.dart';
import 'package:flutter_instagram_clone/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  File _profileImage;

  String _name;
  String _username;
  String _website;
  String _bio;
  String _profileImageURL;

  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      if (_profileImage == null) {
        _profileImageURL = widget.user.profileImageURL;
      } else {
        _profileImageURL = await StorageService.uploadProfileImage(
            widget.user.profileImageURL, _profileImage);
      }

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

  void _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    if (_profileImage != null) {
      return FileImage(_profileImage);
    } else {
      if (widget.user.profileImageURL.isNotEmpty) {
        return CachedNetworkImageProvider(widget.user.profileImageURL);
      } else {
        return AssetImage("assets/images/user_default_image.png");
      }
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _isLoading
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: LinearProgressIndicator(
                            backgroundColor: Colors.black38,
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          ),
                      )
                      : SizedBox.shrink(),
                  CircleAvatar(
                    radius: 65.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _displayProfileImage(),
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
                    onPressed: _handleImageFromGallery,
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
