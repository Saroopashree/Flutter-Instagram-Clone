import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String profileImageURL;
  final String bio;
  final String website;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.profileImageURL,
    this.bio,
    this.website,
  });

  factory User.fromDoc(DocumentSnapshot document) {
    return User(
      id: document.documentID,
      name: document["name"],
      username: document["username"] ?? document["name"],
      email:  document["email"],
      profileImageURL: document["profileImageURL"],
      bio: document["bio"] ?? "",
      website: document["website"] ?? "",
    );
  }
}
