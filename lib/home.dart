import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List stories = List.empty();
  String title = "";
  String author = "";
  String category = "";
  String age = "";
  String image = "";
  String audio = "";
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    stories = [
      "Title",
      "Category",
      "Age ",
      "Image",
      "Audio",
    ];

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load('audio01.mp4');
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  getStoriesList() async {
    return await FirebaseFirestore.instance.collection('StoryCollection').get();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(child,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              //ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(900),
            ],
            background: Container(color: Color.fromARGB(255, 251, 255, 255))),
        initialRoute: "/",
        home: Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              // ignore: unnecessary_new
              return new Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    height: 24.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                      child: Center(
                        child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                            child: Column(children: <Widget>[
                          Text(
                            'Relax Your Mind!',
                            style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Color.fromARGB(255, 233, 62, 10),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("StoryCollection")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                } else if (snapshot.hasData ||
                                    snapshot.data != null) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        QueryDocumentSnapshot<Object?>?
                                            documentSnapshot =
                                            snapshot.data?.docs[index];
                                        return Dismissible(
                                          key: Key(index.toString()),
                                          child: Card(
                                            elevation: 2,
                                            child: ListTile(
                                              leading: Image.asset(
                                                  'assets/images/img01.jpg'),
                                              title: Text((documentSnapshot !=
                                                      null)
                                                  ? (documentSnapshot["title"])
                                                  : ""),
                                              subtitle: Text(
                                                  (documentSnapshot != null)
                                                      ? (documentSnapshot[
                                                          "category"])
                                                      : ""),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                ),
                                                iconSize: 40,
                                                onPressed: () async {
                                                  if (isPlaying) {
                                                    await audioPlayer.pause();
                                                  } else {
                                                    await audioPlayer.resume();
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                                return const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.red,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]))),
                  ),
                ],
              );
            },
            child: SingleChildScrollView(),
          ),
        ));
  }

  // Widget CardUi(
  //     String title, String Category, String age, String photo, String image) {
  //   return Card(
  //       margin: EdgeInsets.all(15),
  //       color: Color(0xfff2fc3),
  //       child: Container(
  //           color: Colors.white,
  //           margin: EdgeInsets.all(1.5),
  //           padding: EdgeInsets.all(10),
  //           child: Column(
  //             children: [
  //               Image.network(
  //                 image,
  //                 fit: BoxFit.cover,
  //                 height: 100,
  //               ),
  //               SizedBox(
  //                 height: 1,
  //               ),
  //               Text(
  //                 title,
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(
  //                 height: 1,
  //               ),
  //               Text("Category: $category"),
  //             ],
  //           )));
  // }
}
