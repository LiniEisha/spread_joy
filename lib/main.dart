import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';
import 'package:spread_joy/login.dart';

//List<CameraDescription>? cameras;
List<CameraDescription> cameras = [];

void main() async {
  //try {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // cameras = await availableCameras();
  cameras = await availableCameras();
  final firstCamera = cameras.first;
  // } on CameraException catch (e) {
  //   print('Error in fetching the cameras: $e');
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),
        body: Login(),
      ),
    );
  }
}
