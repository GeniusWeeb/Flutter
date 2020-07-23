import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/authentication.dart';

import 'UserData.dart';

class DatabaseService {
//collection ref

  Authentication auth = Authentication();
  FirebaseUser user;
  String pop = 'asdsadsadasdda';

  final String uid;
  final String name;
  final String hid;
  DatabaseService({this.uid, this.name, this.hid});

  final CollectionReference collection = Firestore.instance.collection('users');
  final CollectionReference coll = Firestore.instance.collection('host');

  // ignore: non_constant_identifier_names
  Future updateUserData(String name, String email) async {
    return await collection.document(uid).setData({
      'name': name,
      'email': email,
    },
        merge:
            true); //merge means that if data exist then merge and not override
  }

//adding for custom auth ref

//recreating a base collection for ANYONE whos hosts the collection
  Future startSampleTest(String uid, int val) async {
    return await coll
        .document(uid)
        .setData({'host': name, 'value': val, 'joined': []}, merge: true);
  }

  Future test(String uid, int val) async {
    return await coll.document(uid).setData({'value': val}, merge: true);
  }

//trying to get the whole host  stream
//so any changes made to the whole host stream will be reflected onto  the app

  //now first we add the user who opened the link ,to the joined list
  // which is of the type array

  Future addClient(String uid, List name) async {
    return await coll.document(uid).setData({
      'joined': FieldValue.arrayUnion(name),

      //  'name': name,
    }, merge: true);
  }

//---------------------------------------------------------------
//Userdata custom model and mapping from the snapshot right below

  List<User> _userFromSnap(DocumentSnapshot snapshot) {
    String h;
    int v;
    List j;
    return snapshot.data.entries.map((data) {
      if (data.key == "host") {
        h = data.value;
      } else if (data.key == "value") {
        v = data.value;
      } else if (data.key == "joined") {
        j = data.value;
      }
      return User(host: h, joined: j, value: v);
    }).toList();
  }

//stream for the created userid for CLIENT
  Stream<List<User>> get hostData {
    // to delete entry after test done

    return coll.document(hid).snapshots().map(_userFromSnap);
  }

//------------------------------------------------------------------
//deleting the entry after test is over
  Future delele(String uid) async {
    //here we can perfrom all sort of saving stuff and then remove
    //this has to be done from the clients/Host side

    return await coll.document(uid).delete();
  }
}

// 'joined':FieldValue.arrayRemove(name),

//trying to get the whole host  stream
//so any changes made to the whole host stream will be reflected onto  the app

//changes like any user join/ leave should be udates instantly

//except the root node almost everything can be passed in the form of a string

// we dont really define anything
// we ask the users to fill a custom template , where we keep pushing in
