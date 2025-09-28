import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class ResetPasswordUsecase {
  final UserRepository repository;

  const ResetPasswordUsecase({required this.repository});

  Future<void> call({required String email}) async {
    return repository.resetPassword(email);
  }
}
