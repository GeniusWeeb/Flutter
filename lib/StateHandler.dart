import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/signIn.dart';
import 'package:hello/welcome.dart';
import 'package:provider/provider.dart';

void main() => runApp(handle());

class handle extends StatefulWidget {
  @override
  _handleState createState() => _handleState();
}

class _handleState extends State<handle> {
  @override
  Widget build(BuildContext context) {
    //this will basically return a  page
    //depending on the user auth stream

    final user = Provider.of<FirebaseUser>(context);

    if (user == null)
      return test(); //  goes to signIn Screen
    else
      return MainMenu();
  }
}
