import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class SignInUsecase {
  final UserRepository userRepository;

  const SignInUsecase({required this.userRepository});

  Future<UserEntity> call({required String email, required String password}) {
    return userRepository.signIn(email: email, password: password);
  }
}
