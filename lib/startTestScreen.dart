import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hello/authentication.dart';
import 'package:hello/database.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

class firstTest extends StatefulWidget {
  @override
  _firstTestState createState() => _firstTestState();
}

class _firstTestState extends State<firstTest> {
  Authentication auth = Authentication();

  int _start = 100;
  int _current = 100;
  String _link = 'link here';

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome to the first test'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back'),

              // take screen back to initial welcome screen
            ),
            RaisedButton(
              onPressed: () async {
                generateLink();
              },
              child: Text("generate Link"),
            ),
            RaisedButton(
              child: Text('Go'),
              onPressed: () {
                startTimer();
              },
            ),
            Text('$_current'),
            //Text('$_link'),
            new InkWell(
              //wrapped inside inkwell so we can click and copy
              child: new Text(_link),

              onTap: () {
                Clipboard.setData(new ClipboardData(text: _link));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> generateLink() async {
    FirebaseUser user = await auth.handleUser();
    final String id = user.uid;
    //final String name = user.displayName;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://goldenhour.page.link',
        link: Uri.parse('https://goldenhour.page.link/client/?name=$id'),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
            shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
        androidParameters: new AndroidParameters(
          packageName: 'com.zimj.hello',
          minimumVersion: 0,
        ));

    final Uri dyanmicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortlink = await DynamicLinkParameters.shortenUrl(
        dyanmicUrl,
        DynamicLinkParametersOptions(
            shortDynamicLinkPathLength:
                ShortDynamicLinkPathLength.unguessable));
    final Uri shortUrl = shortlink.shortUrl;
    setState(() {
      print("https://goldenhour.page.link" + shortUrl.path);
      _link = "https://goldenhour.page.link" + shortUrl.path;
    });

    return "https://goldenhour.page.link" + shortUrl.path;
  }

//this will be removed in future courtesy of future updates
// this is client side logic where dasta is being pushed simultaneously
  void startTimer() async {
    FirebaseUser user = await auth.handleUser();
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;

        //this line below pushed data to the firesore simultaneously
        //hence we dont need a stream here
        //coz we are pushing from client side
        //we may need a STREAM to finally push this onto the main database
        DatabaseService().test(user.uid, _current);
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }
}
