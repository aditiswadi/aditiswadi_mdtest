import 'package:aditiswadi_mdtest/features/src/domain/entities/user_entity.dart';
import 'package:aditiswadi_mdtest/features/src/domain/usecases/load_users_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadUsersUsecase loadUsersUsecase;

  HomeBloc(this.loadUsersUsecase) : super(const HomeState()) {
    // listen Firestore stream
    on<LoadUsers>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));
      await emit.forEach<List<UserEntity>>(
        loadUsersUsecase(), // Stream<List<UserEntity>>
        onData: (users) => state.copyWith(users: users, loading: false),
        onError: (e, _) => state.copyWith(loading: false, error: e.toString()),
      );
    });

    on<UpdateFilter>(
      (event, emit) => emit(state.copyWith(filter: event.filter)),
    );

    on<UpdateSearch>(
      (event, emit) => emit(state.copyWith(searchTerm: event.search)),
    );
  }
}
