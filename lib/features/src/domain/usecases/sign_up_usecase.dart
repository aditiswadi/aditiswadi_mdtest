import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class SignUpUsecase {
  final UserRepository userRepository;

  const SignUpUsecase({required this.userRepository});

  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return userRepository.signUp(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}
