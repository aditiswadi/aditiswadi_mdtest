// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:aditiswadi_mdtest/features/src/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  });
  Future<UserModel> signIn({required String email, required String password});
  Future<void> signOut();
  Future<void> sendVerificationEmail();
  Future<void> updateVerificationStatus();
  Future<void> resetPassword(String email);
  Stream<User?> get user;
  Stream<List<UserModel>> loadUsers();
  Future<UserModel> getUserById(String uid);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-null',
        message: 'User creation failed',
      );
    }

    final userModel = UserModel(
      id: user.uid,
      fullName: fullName,
      email: email,
      isVerified: false,
    );

    await firestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toFirestore());

    return userModel;
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-null',
        message: 'Login failed: no user returned',
      );
    }

    final doc = await firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        message: 'User document not found in Firestore',
      );
    }

    final data = doc.data()!;
    final userModel = UserModel.fromFirestore(data, doc.id);

    return userModel;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> sendVerificationEmail() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'There is no user login',
      );
    }
    await user.sendEmailVerification();
  }

  @override
  Future<void> updateVerificationStatus() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'There is no user login',
      );
    }

    await user.reload();
    final refreshed = firebaseAuth.currentUser;

    if (refreshed != null) {
      await firestore.collection('users').doc(refreshed.uid).update({
        'isVerified': refreshed.emailVerified,
      });
    }
  }

  @override
  Stream<User?> get user => firebaseAuth.userChanges();

  @override
  Stream<List<UserModel>> loadUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    final data = doc.data()!;
    return UserModel.fromFirestore(data, doc.id);
  }
}
