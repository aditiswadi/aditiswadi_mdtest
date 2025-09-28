import 'dart:async';

import 'package:aditiswadi_mdtest/features/src/data/models/user_model.dart';
import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/reset_password_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/send_verification_email_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/sign_in_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/sign_out_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/sign_up_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/update_verification_status_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/user_changed_state_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignUpUsecase signUpUsecase;
  final SignInUsecase signInUsecase;
  final SignOutUsecase signOutUsecase;
  final SendVerificationEmailUsecase sendEmailVerificationUsecase;
  final UpdateVerificationStatusUsecase updateVerificationStatusUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final UserChangedStateUsecase userChangedStateUsecase;
  late final StreamSubscription authSubscription;

  UserBloc({
    required this.signUpUsecase,
    required this.signInUsecase,
    required this.signOutUsecase,
    required this.sendEmailVerificationUsecase,
    required this.updateVerificationStatusUsecase,
    required this.resetPasswordUsecase,
    required this.userChangedStateUsecase,
  }) : super(UserInitial()) {
    authSubscription = userChangedStateUsecase.call().listen((user) {
      add(UserStateChangedEvent(user: user));
    });

    on<SignUpRequested>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await signUpUsecase.call(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        );
        emit(UserAuthenticated(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await signInUsecase.call(
          email: event.email,
          password: event.password,
        );
        emit(UserAuthenticated(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(UserLoading());
      try {
        await signOutUsecase.call();
        emit(UserUnauthenticated());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UserStateChangedEvent>((event, emit) async {
      if (event.user == null) {
        emit(UserUnauthenticated());
      } else {
        try {
          final userEntity = await userChangedStateUsecase
              .getUserModelFromFirestore(event.user!.uid);
          emit(UserAuthenticated(userEntity));
        } catch (e) {
          emit(UserError(e.toString()));
        }
      }
    });

    on<SendEmailVerificationRequested>((event, emit) async {
      try {
        await sendEmailVerificationUsecase.call();
        final current = state;
        if (current is UserAuthenticated) {
          emit(
            UserActionSuccess(
              "Verification email sent, please check your inbox or spam folder",
              current.user,
            ),
          );
          emit(UserAuthenticated(current.user));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<RefreshEmailVerificationStatus>((event, emit) async {
      try {
        await updateVerificationStatusUsecase.call();
        final current = state;
        if (current is UserAuthenticated) {
          emit(
            UserActionSuccess(
              "Email verification status updated",
              current.user,
            ),
          );
          emit(UserAuthenticated(current.user));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(UserLoading());
      try {
        await resetPasswordUsecase.call(email: event.email);
        final current = state;
        if (current is UserAuthenticated) {
          emit(UserActionSuccess("Password reset email sent", current.user));
        } else {
          emit(
            UserActionSuccess("Password reset email sent", UserEntity.empty()),
          );
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
