part of 'user_bloc.dart';

/// Semua event untuk UserBloc
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// -----------------
///  AUTHENTICATION
/// -----------------
/// Mendaftarkan akun baru
class SignUpRequested extends UserEvent {
  final String fullName;
  final String email;
  final String password;

  const SignUpRequested({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}

/// Login user
class SignInRequested extends UserEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Logout user
class SignOutRequested extends UserEvent {
  const SignOutRequested();
}

/// Listener perubahan status autentikasi dari FirebaseAuth
class UserStateChangedEvent extends UserEvent {
  final User? user;
  const UserStateChangedEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

/// -----------------
///  EMAIL VERIFY
/// -----------------
/// Kirim link verifikasi email ke user saat ini
class SendEmailVerificationRequested extends UserEvent {
  const SendEmailVerificationRequested();
}

/// Cek ulang status emailVerified di FirebaseAuth
/// dan update field isVerified di Firestore.
class RefreshEmailVerificationStatus extends UserEvent {
  const RefreshEmailVerificationStatus();
}

/// -----------------
///  PASSWORD RESET
/// -----------------
/// Kirim email reset password ke alamat tertentu
class ResetPasswordRequested extends UserEvent {
  final String email;
  const ResetPasswordRequested(this.email);

  @override
  List<Object?> get props => [email];
}
