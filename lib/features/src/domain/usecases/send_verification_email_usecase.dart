import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class SendVerificationEmailUsecase {
  final UserRepository userRepository;

  const SendVerificationEmailUsecase({required this.userRepository});

  Future<void> call() async {
    return userRepository.sendVerificationEmail();
  }
}
