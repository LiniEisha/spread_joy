import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(children: <Widget>[
              Text(
                'My Profile!',
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = const Color.fromARGB(255, 233, 62, 10),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
