import 'package:aditiswadi_mdtest/features/src/data/datasources/user_remote_data_source.dart';
import 'package:aditiswadi_mdtest/features/src/data/repositories/user_repository_impl.dart';
import 'package:aditiswadi_mdtest/features/src/domain/repositories/user_repository.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/load_users_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/reset_password_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/send_verification_email_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/sign_in_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/sign_out_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/sign_up_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/update_verification_status_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/user_changed_state_usecase.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/home/home_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/user/user_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(
    () => UserBloc(
      signUpUsecase: sl(),
      signInUsecase: sl(),
      signOutUsecase: sl(),
      sendEmailVerificationUsecase: sl(),
      updateVerificationStatusUsecase: sl(),
      resetPasswordUsecase: sl(),
      userChangedStateUsecase: sl(),
    ),
  );

  sl.registerFactory(() => HomeBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => SignUpUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => SignInUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => SignOutUsecase(userRepository: sl()));
  sl.registerLazySingleton(
    () => SendVerificationEmailUsecase(userRepository: sl()),
  );
  sl.registerLazySingleton(
    () => UpdateVerificationStatusUsecase(repository: sl()),
  );
  sl.registerLazySingleton(() => ResetPasswordUsecase(repository: sl()));
  sl.registerLazySingleton(() => UserChangedStateUsecase(repository: sl()));

  sl.registerLazySingleton(() => LoadUsersUsecase(userRepository: sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  );
}
