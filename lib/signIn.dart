import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello/authentication.dart';
import 'package:hello/loading.dart';

//initiating variables of the plugins

void main() => runApp(test());

// ignore: camel_case_types
class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

// ignore: camel_case_types
class _testState extends State<test> {
  Authentication _auth = Authentication();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? loader()
        : Scaffold(
            appBar: AppBar(
              title: Text('My golden hour'),
              centerTitle: true,
              backgroundColor: Colors.amber[200],
            ),
            floatingActionButton: FloatingActionButton(
                child: Text('signIn'),
                onPressed: () async {
                  try {
                    setState(() {
                      loading = true;
                    });
                    await _auth.handleSignIn();
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                  }
                }),
          );
  }
}
