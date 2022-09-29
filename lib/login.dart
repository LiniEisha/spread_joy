import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'resuableText.dart';
import 'tabView.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/logo.png'), fit: BoxFit.cover),
      // ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Stack(
          children: [
            Image.asset('assets/images/logo.png'),
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Color.fromARGB(255, 247, 244, 244),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          reusableTextField(
                              "Enter UserName",
                              Icons.person_outline,
                              false,
                              _emailTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Enter Password",
                              Icons.lock_outline,
                              true,
                              _passwordTextController),
                          const SizedBox(
                            height: 5,
                          ),
                          // forgetPassword(context),
                          firebaseButton(context, "Sign In", () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabView()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          }),
                          newUser()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row newUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signup()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
