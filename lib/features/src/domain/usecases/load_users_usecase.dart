import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';

class LoadUsersUsecase {
  final UserRepository userRepository;

  const LoadUsersUsecase({required this.userRepository});

  Stream<List<UserEntity>> call() {
    return userRepository.loadUsers();
  }
}
