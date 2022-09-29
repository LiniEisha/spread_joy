import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

class FirestoreService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadAudio(
    String audioFilePath,
    String audioFileName,
  ) async {
    File file = File(audioFilePath);

    try {
      await storage.ref('audio/$audioFileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> uploadImage(
    String imageFilePath,
    String imageFileName,
  ) async {
    File file = File(imageFilePath);

    try {
      await storage.ref('images/$imageFileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
