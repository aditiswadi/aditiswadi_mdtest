import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class SignOutUsecase {
  final UserRepository userRepository;

  const SignOutUsecase({required this.userRepository});

  Future<void> call() async {
    await userRepository.signOut();
  }
}
