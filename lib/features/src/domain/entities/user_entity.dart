import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isVerified,
  });

  static UserEntity empty() {
    return const UserEntity(id: '', fullName: '', email: '', isVerified: false);
  }

  @override
  List<Object> get props => [id, fullName, email, isVerified];
}
