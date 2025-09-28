import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class UpdateVerificationStatusUsecase {
  final UserRepository repository;

  UpdateVerificationStatusUsecase({required this.repository});

  Future<void> call() async {
    return await repository.updateVerificationStatus();
  }
}
