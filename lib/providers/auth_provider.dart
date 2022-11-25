import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/exception/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _showLoginPage = true;
  void toggleAuthPage() {
    _showLoginPage = !_showLoginPage;
    notifyListeners();
  }

  bool get showLoginPage => _showLoginPage;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    }
  }

  Future<void> createFirestoreUser({
    required String firstname,
    required String lastname,
    required String email,
  }) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'time': Timestamp.fromDate(DateTime.now())
      });
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> createFirebaseUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (_) {
      throw GenericAuthException();
    }
  }

  String get getUserUid => FirebaseAuth.instance.currentUser!.uid;
  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotFoundAuthException();
    }
  }

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  Future<void> initialFirebase() async {
    await Firebase.initializeApp();
  }
}
