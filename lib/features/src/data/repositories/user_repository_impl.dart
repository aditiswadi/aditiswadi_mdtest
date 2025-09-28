import 'package:aditiswadi_mdtest/features/src/data/datasources/user_remote_data_source.dart';
import 'package:aditiswadi_mdtest/features/src/data/models/user_model.dart';
import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  const UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<UserEntity> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final UserModel model = await userRemoteDataSource.signUp(
      fullName: fullName,
      email: email,
      password: password,
    );

    return model.toEntity();
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final UserModel model = await userRemoteDataSource.signIn(
      email: email,
      password: password,
    );

    return model.toEntity();
  }

  @override
  Future<void> signOut() async {
    await userRemoteDataSource.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await userRemoteDataSource.resetPassword(email);
  }

  @override
  Future<void> sendVerificationEmail() async {
    await userRemoteDataSource.sendVerificationEmail();
  }

  @override
  Future<void> updateVerificationStatus() async {
    await userRemoteDataSource.updateVerificationStatus();
  }

  @override
  Stream<User?> get user => userRemoteDataSource.user;

  @override
  Stream<List<UserEntity>> loadUsers() {
    return userRemoteDataSource.loadUsers().map((models) {
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<UserEntity> getUserById(String uid) async {
    final userModel = await userRemoteDataSource.getUserById(uid);
    return userModel.toEntity();
  }
}
