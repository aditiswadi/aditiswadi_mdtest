import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<UserEntity> signUp({
    required String fullName,
    required String email,
    required String password,
  });
  Future<UserEntity> signIn({required String email, required String password});
  Future<void> signOut();
  Future<void> sendVerificationEmail();
  Future<void> updateVerificationStatus();
  Future<void> resetPassword(String email);
  Stream<User?> get user;
  Stream<List<UserEntity>> loadUsers();
  Future<UserEntity> getUserById(String uid);
}
