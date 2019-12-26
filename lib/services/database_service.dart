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
}
