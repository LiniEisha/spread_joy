import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'resuableText.dart';
import 'tabView.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Image.asset('assets/images/logo.png'),
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(
                  fontSize: 40,
                  //color: Colors.white
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
                    top: MediaQuery.of(context).size.height * 0.28),
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
                              _userNameTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Enter Email Id",
                              Icons.person_outline,
                              false,
                              _emailTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Enter Password",
                              Icons.lock_outlined,
                              true,
                              _passwordTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          firebaseButton(context, "Sign Up", () {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              print("Created New Account");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabView()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          })
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

  Row exsistingUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text(
            " Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
