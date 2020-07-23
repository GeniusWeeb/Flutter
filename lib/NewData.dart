import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UserData.dart';

// ignore: camel_case_types
class newData extends StatefulWidget {
  final String uid;

  newData({this.uid});
  @override
  _newDataState createState() => _newDataState();
}

// ignore: camel_case_types
class _newDataState extends State<newData> {
  int val = 0;
  String name;
  List join = [];
  @override
  Widget build(BuildContext context) {
    final pullData = Provider.of<List<User>>(context);

    // print(pullData[1].host);
    // print(pullData[1].joined);
    // print(pullData[2].value);
    setState(() {
      val = pullData[2].value;
      name = pullData[1].host;
      join = pullData[1].joined;
    });
    print(pullData[2].value);
    // pullData.forEach((doc) {
    //   print(doc.value);
    //   for (var el in doc.joined) {
    //     print(el);
    //   }
    // }
    //)
    ;

    return Scaffold(
      body: Center(
          child: Column(children: [
        new Text('Host Name:$name'),
        new Text('Reading Value:$val'),
        //only the joined section goes into the future list builder section
        //or tile view and we open it up into seperate list elements
        new Text('people here :$join ')
      ])),
    );
  }
}
