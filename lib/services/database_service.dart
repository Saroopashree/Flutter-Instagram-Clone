import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';
import 'package:flutter_instagram_clone/utilities/constants.dart';

class DatabaseService {
//  final User user;
//
//  DatabaseService({this.user});

  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      "name": user.name,
      "username": user.username,
      "bio": user.bio,
      "profileImageURL": user.profileImageURL,
      "website": user.website,
    });
  }

  static Future<QuerySnapshot> searchUsers(String textInput) {
    Future<QuerySnapshot> users = usersRef
        .where("username", isGreaterThanOrEqualTo: textInput)
        .getDocuments();
    return users;
  }
}
