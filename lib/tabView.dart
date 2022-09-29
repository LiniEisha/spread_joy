import 'package:flutter/material.dart';
import 'home.dart';
import 'addItems.dart';
import 'login.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  _TabView createState() => _TabView();
}

class _TabView extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 121, 28, 0),
            title: const Text('Spread Joy'),
            elevation: 20,
            actions: [
              IconButton(
                  icon: Icon(Icons.logout_rounded),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()))
                      }),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.add)),
                //Tab(icon: Icon(Icons.person)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Home(),
              MyCustomForm(),
              //Profile(),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const Login()));
          //     //signOut();
          //   },
          //   child: Icon(Icons.logout_rounded),
          //   backgroundColor: Color.fromARGB(255, 121, 28, 0),
          // ),
        ),
      ),
    );
  }
}
