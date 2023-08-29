import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/models/employee/emp_model.dart';
import 'package:task/models/user/user_model.dart';
import 'package:task/utils/exceptions.dart';

class FirestoreRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> postUserDetailstoFirestore(
    UserModel userModel,
  ) async {
    _firebaseFirestore.collection('user').doc(userModel.uid).set(
          userModel.toJson(),
        );
  }

  Future<bool> isUserDocumentEmpty(
    String id,
  ) async {
    bool isPresent = false;
    try {
      await _firebaseFirestore
          .collection('user')
          .doc(id)
          .snapshots()
          .first
          .then((value) {
        isPresent = value.exists;
      });
      return isPresent;
    } on FirebaseAuthException catch (e) {
      throw UnknownException("Something went wrong ${e.code} ${e.message}");
    }
  }

  static User? checkUser() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    return user;
  }

  Future<void> uploadEmpInformation(
    EmpModel empModel,
  ) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      _firebaseFirestore
          .collection('user')
          .doc(uid)
          .collection('employees')
          .doc(empModel.name)
          .set(empModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw UnknownException("Something went wrong ${e.code} ${e.message}");
    }
  }

  Stream<List<EmpModel?>> getAllEmps() {
    return _firebaseFirestore
        .collection('user')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('employees')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => EmpModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}
