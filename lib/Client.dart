import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/authentication.dart';
import 'package:hello/database.dart';
import 'package:provider/provider.dart';

import 'NewData.dart';
import 'UserData.dart';

void main() {
  runApp(cClient());
}

class cClient extends StatefulWidget {
  String id;
  String name;
  String hostName;
  cClient({this.id});
  @override
  _cClientState createState() {
    return _cClientState(id: this.id);
  }
}

class _cClientState extends State<cClient> {
  String id;
  Authentication auth = Authentication();
  // this contans the user id

  //we need to create another function or FIrebase user that will store the current
  //user , so we can add him to the list of people joined there
  _cClientState({this.id});
  @override
  void initState() {
    super.initState();
    this.start();
  }

  void start() async {
    FirebaseUser user = await auth.handleUser();
    String uid = id;

    var data = [];
    data = [user.displayName];
    DatabaseService().addClient(uid, data);
  }

//id = user id we pulled from the dynamic Link as it got passed to client from welcome screen
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
        value: DatabaseService(hid: id).hostData,
        child: Scaffold(
          appBar: AppBar(
            title: Text('$id'),
          ),
          //we create a small  space widget for our screen
          body: newData(uid: id),

          // RaisedButton(onPressed: () {}),
        ));
  }
}
