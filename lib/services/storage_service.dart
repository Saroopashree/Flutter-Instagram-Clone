import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_instagram_clone/utilities/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {

  static Future<String> uploadProfileImage (String url, File imageFile) async {
    String imageId = Uuid().v4();
    File image = await compressImage(imageId, imageFile);

    if (url != null) {
      // User updates an existing profile image
      RegExp exp = RegExp(r'profileImage_(.*).jpg');
      imageId = exp.firstMatch(url)[1];
      print(imageId);
    }

    StorageUploadTask uploadTask = storageRef.child("images/users/profileImage_$imageId.jpg").putFile(image);
          // Uploads the image File into "images/users" directory
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  static Future<File> compressImage (String imageId, File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = tempDir.path;
    final compressedImage = await FlutterImageCompress.compressAndGetFile(imageFile.absolute.path, "$targetPath/img_$imageId.jpg", quality: 60);
    return compressedImage;
  }

}