import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadFile(File file, {String path = 'images/'}) async {
    final fileRef = storageRef.child('$path/${file.path.split(Platform.pathSeparator).last}');
    await fileRef.putFile(file);
    return fileRef.getDownloadURL();
  }
}