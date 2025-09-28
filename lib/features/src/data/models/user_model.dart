// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.isVerified,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'isVerified': isVerified,
    };
  }

  UserEntity toEntity() => UserEntity(
    id: id,
    fullName: fullName,
    email: email,
    isVerified: isVerified,
  );

  factory UserModel.fromFirestore(Map<String, dynamic> json, String docId) {
    return UserModel(
      id: docId,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }
}
