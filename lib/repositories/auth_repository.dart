import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/utils/exceptions.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(
    String email,
    String password,
  ) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException('Email already in use');
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    }
    return userCredential;
  }

  Future<UserCredential?> signIn(
    String email,
    String password,
  ) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(userCredential.user?.email.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw WrongPasswordException('User name of password is incorrect');
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    }
    return userCredential;
  }
}
