import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'tabView.dart';
import 'firestoreService.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class MyCustomForm extends StatefulWidget {
  createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late File? _image = File('initial file');

  List stories = List.empty();
  String title = "";
  String author = "";
  String category = "";
  String age = "";
  String audioPath = "";
  String imagePath = "";

  @override
  void initState() {
    // _status = '';
    // _imageLoading = false;
    // _imagePicker = ImagePicker();
    stories = [
      "Hello",
      "Hey There",
      "Hey ",
      "Hey There",
      "imagePicker1",
      "audio"
    ];
  }

  Future pickImageCamera() async {
    final selected = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = selected as File?;
    });
  }

  Future pickImageGallery() async {
    final selected = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selected as File?;
    });
  }

  void _clear() {
    setState(() => _image = null);
  }

  createStories() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("StoryCollection").doc(title);

    Map<String, String> storyList = {
      "title": title,
      "author": author,
      "category": category,
      "age": author,
      "audio": audioPath,
      "photo": imagePath,
    };

    documentReference
        .set(storyList)
        .whenComplete(() => print("Data stored successfully"));
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService storage = FirestoreService();
    return Form(
      //key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              Text(
                'Boadcast!',
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Color.fromARGB(255, 233, 62, 10),
                ),
              ),
              Container(
                //padding: const EdgeInsets.all(25.0),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.001),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(children: [
                          TextFormField(
                              //controller: titleController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                //icon: const Icon(Icons.person),
                                hintText: 'Enter Title',
                                labelText: 'Title',
                              ),
                              onChanged: (String value) {
                                title = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter Title';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                              //controller: authorController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                //icon: const Icon(Icons.phone),
                                hintText: 'Enter Author',
                                labelText: 'Author',
                              ),
                              onChanged: (String value) {
                                author = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter the Author Name';
                                }
                                return null;
                              }),
                          TextFormField(
                              //controller: categoryController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                //icon: const Icon(Icons.phone),
                                hintText: 'Enter Category',
                                labelText: 'Category',
                              ),
                              onChanged: (String value) {
                                category = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter the Author Name';
                                }
                                return null;
                              }),
                          Text('Ex: Kids, Teen, Motivation, Experiences'),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              //controller: ageController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                //icon: const Icon(Icons.phone),
                                hintText: 'Enter Recommended age',
                                labelText: 'ageCategory',
                              ),
                              onChanged: (String value) {
                                age = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please the recommended age';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Table(
                            defaultColumnWidth: FixedColumnWidth(150.0),
                            border: TableBorder.all(
                              color: Color.fromARGB(255, 133, 50, 50),
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Text('Add a Photo',
                                      style: TextStyle(fontSize: 20.0))
                                ]),
                                Column(children: [
                                  Text('Add the Audio',
                                      style: TextStyle(fontSize: 20.0))
                                ]),
                              ]),
                              TableRow(
                                children: [
                                  Column(
                                    children: [
                                      //_image == null
                                      // ?
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 133, 50, 50),
                                          ),
                                          onPressed: pickImageCamera,
                                          child: Text("Take a Photo")),
                                      // : Image.file(_image!),
                                      Text('OR'),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 133, 50, 50),
                                          ),
                                          onPressed: () async {
                                            final file = await FilePicker
                                                .platform
                                                .pickFiles(
                                              allowMultiple: false,
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'png',
                                                'jpg',
                                              ],
                                            );
                                            if (file == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'No file selected')),
                                              );
                                              return null;
                                            }
                                            imagePath = file.files.single.path!;
                                            final fileName =
                                                file.files.single.name;

                                            storage
                                                .uploadImage(
                                                    imagePath, fileName)
                                                .then((value) => print('Done'));
                                          },
                                          child: Text("Select Image"))
                                    ],
                                  ),
                                  Column(children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 133, 50, 50),
                                      ),
                                      onPressed: () async {
                                        final file =
                                            await FilePicker.platform.pickFiles(
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowedExtensions: [
                                            'mp3',
                                            'mp4',
                                            'mpeg'
                                          ],
                                        );
                                        if (file == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('No file selected')),
                                          );
                                          return null;
                                        }
                                        audioPath = file.files.single.path!;
                                        final fileName = file.files.single.name;

                                        storage
                                            .uploadAudio(audioPath, fileName)
                                            .then((value) => print('Done'));
                                      },
                                      child: Text("Add the audio"),
                                    ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 150.0, top: 40.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Color.fromARGB(255, 133, 50, 50),
                                ),
                                onPressed: () {
                                  setState(() {
                                    createStories();
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabView()));
                                },
                                child: const Text('Upload'),
                              )),
                        ]),
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
