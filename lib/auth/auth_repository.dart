import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final FirebaseAuth _auth; // = FirebaseAuth.instance;

  AuthRepository(this._auth);

  Future<String> attemptAutoLogin() async {
    var _subscription = FirebaseAuth.instance.userChanges().listen((User user) {
      if (user != null) {
        return user.displayName;
      } else {
        return null;
      }
    });
  }

  Future<User> login({
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result != null) {
        User user = result.user;
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<User> signUp({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user?.updateDisplayName(username);
    if(result!=null)
     { User user = result.user;
      return user;}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signOut() async {
    try {
       await _auth.signOut();
       return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
