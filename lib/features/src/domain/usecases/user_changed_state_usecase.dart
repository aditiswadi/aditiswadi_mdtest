import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserChangedStateUsecase {
  final UserRepository repository;

  UserChangedStateUsecase({required this.repository});
  Stream<User?> call() {
    return repository.user;
  }

  Future<UserEntity> getUserModelFromFirestore(String uid) {
    return repository.getUserById(uid);
  }
}
