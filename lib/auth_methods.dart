import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:instagram_clone/storageMethods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some Error";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        model.User user = model.User(
          username: username,
          uid: credential.user!.uid,
          email: email,
          photoUrl: photoUrl,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly format';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error Occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = "Please check your Fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly format';
      } else {
        if (err.code == 'wrong-password') {
          res = 'The email is badly format';
        }
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
