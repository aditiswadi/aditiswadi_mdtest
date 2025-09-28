part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

/// ---- State Awal ----
class UserInitial extends UserState {}

/// ---- Loading umum untuk aksi apa pun ----
class UserLoading extends UserState {}

/// ---- User berhasil login / signup ----
class UserAuthenticated extends UserState {
  final UserEntity user;
  const UserAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}

/// ---- User tidak login ----
class UserUnauthenticated extends UserState {}

/// ---- Pesan sukses atau info spesifik ----
class UserActionSuccess extends UserState {
  final String message; // contoh: "Verification email sent"
  final UserEntity user;
  const UserActionSuccess(this.message, this.user);
  @override
  List<Object?> get props => [message, user];
}

/// ---- Error umum ----
class UserError extends UserState {
  final String message;
  const UserError(this.message);
  @override
  List<Object?> get props => [message];
}
