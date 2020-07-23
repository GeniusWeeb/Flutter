import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello/UserProfile.dart';
import 'package:hello/database.dart';
import 'package:hello/holders.dart';
import 'package:hello/signIn.dart';
import 'package:provider/provider.dart';

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // bool loading = false;
//building a stream for the auth user to listen to
  Stream<FirebaseUser> get authState {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

//  Calls the database Service and then updates user data
// if any new info has been added ak.a the user is old
// we will merge the data with existin ones else we
// will just create a new entry

    await DatabaseService(uid: user.uid)
        .updateUserData(user.displayName, user.email);

    print("signed in" + user.displayName);

    return user;
  }

  //creating a sign out service

  // ignore: missing_return
  Future<FirebaseUser> handleSignOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

//creating a function to return the currently authenticated firebase user
  handleUser() async {
    return _auth.currentUser();
  }
}
