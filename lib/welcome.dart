import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hello/Client.dart';
import 'package:hello/UserProfile.dart';
import 'package:hello/authentication.dart';
import 'package:hello/database.dart';
import 'package:hello/startTestScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MainMenu());

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Authentication auth = Authentication();
  User player;
  String id;
  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

//only processed once
    //FirebaseDynamicLinks.instance.getDynamicLink(data.link);

    final Uri deeplink = data?.link;
    if (deeplink != null) {
      id = deeplink.queryParameters['name'];

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => cClient(id: id)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // for the data snapshot value
    //  this has to be essentially put
    //into the various clients section
    //has been wrapped for data passsing of to te HOST

    return MaterialApp(
      routes: {
        'client': (context) => cClient(),
      },
      home: Scaffold(
          appBar: AppBar(
            title: Text("welcome !!"),
            centerTitle: true,
          ),
          body: Center(
              child: Column(
            children: [
              RaisedButton(
                child: Text("sign out"),
                elevation: 5.0,
                onPressed: () async {
                  await auth.handleSignOut();
                },
              ),
              RaisedButton(

                  //2 button
                  child: Text('Start Test'), // we go to a new screen
                  elevation: 5.0,
                  onPressed: () async {
                    FirebaseUser user = await auth.handleUser();
                    await DatabaseService(uid: user.uid, name: user.displayName)
                        .startSampleTest(user.uid, 0);

                    //changing screens after above task is complete
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => firstTest()));
                  }),
              // RaisedButton(
              //   //3rd button
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => cClient()));
              //   },
              //   child: Text("Sample Button"),
              // )
            ],
          ))),
    );
  }
}
